;;; elpaca-bootstrap.el --- Elpaca package manager bootstrap -*- lexical-binding: t; -*-

;;; Commentary:
;; https://github.com/progfolio/elpaca
;;
;; Reproducibility: `elpaca-lock-file' pins every package to an exact commit.
;; It is read by `elpaca-menu-lock-file', which is already the FIRST entry of
;; the default `elpaca-menu-functions', so locked refs win and the regular
;; menus stay available as a fallback for packages not yet in the lock file.
;;
;; The lock file is written only when it is absent (a first install, via
;; `elpaca-after-init-hook') or on demand (`vb/elpaca-write-lock-file').  An
;; existing lock file is never rewritten at startup: doing so would silently
;; replace the pinned refs with whatever happened to be checked out.
;;; Code:

(require 'core)

;; ---------------------------------------------------------------------------
;; Lock file -- must be set before any package is queued.

(defconst vb/elpaca-lock-file (expand-file-name "elpaca-lock.el" init-el-directory)
  "Where this configuration keeps its pinned package versions.")

;; Only point Elpaca at the file when it exists: `elpaca-menu-lock-file' never
;; caches a missing file, so each package lookup would re-read it and warn.
(when (file-exists-p vb/elpaca-lock-file)
  (setq elpaca-lock-file vb/elpaca-lock-file))

;; Upstream default is nil, i.e. build every package at once.  A first install
;; is ~47 concurrent clones and compiles; throttle it.  This setting hangs a
;; wholly failing install on its own -- see the `elpaca-subscribe' near the
;; installer below, which is what makes it safe.
(setq elpaca-queue-limit 10)

;; Declared so the `let' below binds dynamically.  These are defcustoms in
;; elpaca.el, which is not loaded when this file is compiled; without the
;; declaration a byte-compiled copy binds lexically, `elpaca-write-lock-file'
;; sees the global value, and every transitive dependency silently drops out
;; of the lock file.
(defvar elpaca-lock-file-functions)
(defvar elpaca-lock-file)
(defvar elpaca-menu-lock-file--cache)

(defun vb/elpaca--unfinished ()
  "Return the names of queued orders that are not `finished'."
  (delq nil (mapcar (lambda (c)
                      (unless (eq (elpaca<-status (cdr c)) 'finished)
                        (car c)))
                    (elpaca--queued))))

(defun vb/elpaca--write-lock-file ()
  "Write the installed package set to `vb/elpaca-lock-file'.
Return non-nil on success.  Writes through a temporary file so a partial
or failed write cannot damage an existing lock file: `elpaca-ref' signals
for any package whose clone failed, and `elpaca-write-lock-file' writes to
its destination directly."
  ;; `elpaca-ref' only signals when `git rev-parse HEAD' fails, i.e. when the
  ;; clone failed.  A package that cloned but failed to *build* still has a
  ;; ref, so without this check it would be pinned in its broken state and the
  ;; user told to commit it.  Refuse up front instead, on the same "every order
  ;; finished" rule `test-startup.sh' applies.
  (if-let* ((unfinished (vb/elpaca--unfinished)))
      (progn
        (warn "Not writing %s: these packages are not installed: %S
Fix them, then run M-x vb/elpaca-write-lock-file."
              vb/elpaca-lock-file unfinished)
        nil)
    (let ((tmp (make-temp-file "elpaca-lock")))
    (unwind-protect
        (condition-case err
            (progn
              ;; Nil so transitive dependencies (compat, ...) are recorded;
              ;; the default filter keeps only orders queued from init.el.
              (let ((elpaca-lock-file-functions nil))
                (elpaca-write-lock-file tmp))
              ;; An `if': the success branch has to be what the function
              ;; returns.  As a `when' inside this `progn' its value was
              ;; discarded and the warning below ran on every success.
              (if (with-temp-buffer (insert-file-contents tmp)
                                    (ignore-errors (read (current-buffer))))
                  (progn
                    ;; `make-temp-file' creates 0600; the lock file is
                    ;; committed and may be read by another user (the Docker
                    ;; image builds and runs as different users).  Set the mode
                    ;; on the temp file, so `copy-file' is the last step that
                    ;; can signal -- otherwise the handler below would report a
                    ;; failure for a destination it had already replaced.
                    (set-file-modes tmp (logand (default-file-modes) #o666))
                    (copy-file tmp vb/elpaca-lock-file t)
                    ;; Only now: until the copy succeeds the destination may
                    ;; not exist, and the guard above deliberately leaves
                    ;; `elpaca-lock-file' nil in that case.
                    (setq elpaca-lock-file vb/elpaca-lock-file)
                    ;; `elpaca-menu-lock-file' fills its cache once per session
                    ;; and never re-reads.  Without this, anything resolved
                    ;; later in this session (elpaca-try, re-evaluating a
                    ;; use-package form, a new transitive dep) would still see
                    ;; the refs the file had at startup, not the ones just
                    ;; written.
                    (setq elpaca-menu-lock-file--cache nil)
                    t)
                ;; `elpaca-write-lock-file' writes a literal nil when it
                ;; records nothing; without this the caller is silent and no
                ;; lock file ever appears.
                (warn "Elpaca recorded no packages; %s not written"
                      vb/elpaca-lock-file)
                nil))
          (error
           ;; Leave any existing lock file untouched rather than replacing it
           ;; with one that misdescribes what is installed.
           (warn "Could not write the elpaca lock file: %S
Every package must install first; these have not: %S
Fix them, then run M-x vb/elpaca-write-lock-file."
                 err (vb/elpaca--unfinished))
           nil))
        (delete-file tmp)))))

(defun vb/elpaca-write-lock-file ()
  "Record the currently installed packages in `vb/elpaca-lock-file'.
Use this to repair or refresh the lock file in place -- it pins whatever
is installed right now and downloads nothing.  `vb/elpaca-update' is the
destructive counterpart that first reinstalls everything at current
upstream versions."
  (interactive)
  ;; A pending reinstall would wipe the tree on the next start and reinstall
  ;; the very commits this would pin, so disarm it rather than record them.
  (let ((marker (expand-file-name "elpaca-reinstall" user-emacs-directory)))
    (when (file-exists-p marker)
      (delete-file marker)
      (message "Cancelled the pending reinstall: pinning what is installed now")))
  (when (vb/elpaca--write-lock-file)
    (message "Elpaca lock file written to %s -- commit it" vb/elpaca-lock-file)))

;; No lock file yet (first install, or it was deleted): resolve everything from
;; the menus this once, then record the result so the next start is pinned.
;; An existing lock file is never written to at startup.
(unless (file-exists-p vb/elpaca-lock-file)
  (vb/log "No elpaca lock file at %s; resolving from the menus and recording it"
          vb/elpaca-lock-file)
  (add-hook 'elpaca-after-init-hook #'vb/elpaca-write-lock-file))

;; ---------------------------------------------------------------------------
;; Package-tree maintenance.  All of it runs here, before anything is loaded
;; from the tree, so nothing can be pulled out from under a live session.

;; `vb/elpaca-update' asked for a reinstall.  Deleting here is safe: no build
;; directory is on `load-path' yet.
(let ((marker (expand-file-name "elpaca-reinstall" user-emacs-directory))
      (tree (expand-file-name "elpaca/" user-emacs-directory)))
  (when (file-exists-p marker)
    (vb/log "Reinstall requested; removing %s" tree)
    ;; Drop the marker first: if the delete below signals (a build subtree
    ;; owned by another uid, ESTALE, ...) an unguarded failure here would
    ;; abort init.el, and a surviving marker would repeat that abort on every
    ;; subsequent start -- with `vb/elpaca-update' never reached to undo it.
    (condition-case err
        (progn
          ;; Marker first, and inside the guard: a failure escaping this
          ;; top-level form would abort init.el, and a surviving marker would
          ;; repeat that abort on every start.
          (delete-file marker)
          (when (file-directory-p tree) (delete-directory tree t)))
      (error (warn "Reinstall cleanup failed (%S).
Remove %s and %s by hand, then restart" err marker tree)))))

;; Installer 0.12 renamed the source tree repos/ -> sources/.  On an install
;; made by 0.11 the old builds/elpaca/ is what the verbatim installer below
;; puts on `load-path' (it prepends the build dir before cloning), so `require'
;; would load 0.11 against this 0.12 config and only whisper about it via
;; `lwarn'.  Erroring here would abort init.el before anything -- including
;; `vb/elpaca-update' -- is defined, so remove the old tree and let the
;; installer do a clean 0.12 install; the lock file makes that reproducible.
;; Deleting is safe for the same reason as above, and avoids holding two full
;; package trees on disk.
(let ((legacy (expand-file-name "elpaca/repos/" user-emacs-directory)))
  (when (file-directory-p legacy)
    (let ((tree (expand-file-name "elpaca/" user-emacs-directory)))
      ;; Renamed, not deleted: if the 0.12 install then fails (offline, or
      ;; GitHub unreachable) the old tree is still there to move back, rather
      ;; than an Emacs with no packages at all.  Left for the user to remove --
      ;; nothing sweeps it, so it cannot disappear before they know it worked.
      ;; The name is timestamped because `rename-file' signals on an existing
      ;; non-empty directory even with OK-IF-ALREADY-EXISTS, and this is a
      ;; top-level form: a signal here would abort init.el entirely.
      (let ((aside (format "%s.0.11-%s" (directory-file-name tree)
                           (format-time-string "%Y%m%d%H%M%S"))))
        (condition-case err
            (progn
              (rename-file (directory-file-name tree) aside)
              (warn "Elpaca 0.11 layout found; the old tree is now %s.
Reinstalling under the 0.12 layout; delete that directory once this works."
                    aside))
          (error
           ;; The rename failed, so the 0.11 tree is still in place and the
           ;; verbatim installer below would find its builds/elpaca/, put it
           ;; on `load-path' and `require' 0.11 -- the exact mix this block
           ;; exists to prevent, while the warning tells the user to restart.
           ;; Builds are regenerable (the sources are the part worth keeping),
           ;; so dropping just builds/ defuses it and still leaves repos/ for
           ;; recovery.  Without a build dir the installer falls back to the
           ;; freshly cloned 0.12 source.
           (let ((builds (expand-file-name "elpaca/builds/" user-emacs-directory)))
             (condition-case err2
                 (when (file-directory-p builds) (delete-directory builds t))
               (error
                ;; Last resort.  Aborting init.el is bad, but booting a config
                ;; silently running the wrong Elpaca is worse, and the user has
                ;; to intervene by hand either way.
                (error "Elpaca 0.11 layout at %s could not be moved aside (%S)\
 and its builds could not be removed (%S).  Move %s away by hand, then restart"
                       legacy err err2 (directory-file-name tree)))))
           (warn "Elpaca 0.11 layout at %s could not be moved aside (%S).
Its build directory was removed so the 0.12 installer can take over; the old
sources are still at %s.  Move or delete them by hand once this works."
                 legacy err legacy)))))))

;; ---------------------------------------------------------------------------
;; Install Elpaca package manager (upstream installer, keep verbatim)

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
;; Makes `elpaca-queue-limit' above survive a failing install.  Elpaca releases
;; throttled orders only from `elpaca--release-throttled', which it subscribes
;; to the `finished' and `blocked' transitions -- not to `failed'.  A failed
;; order does not occupy a slot (`failed' is excluded from that function's
;; `active' count), but nothing calls the releaser to hand the free slot out.
;; So when every in-flight order fails -- no network, or a forge down -- the
;; throttled remainder waits forever and `elpaca-wait' never returns: an
;; interactive Emacs hangs at startup, escapable only with C-g.
;;
;; Verified here rather than reasoned about: with elpaca installed but all
;; package clones failing, `elpaca-wait' never returned with the throttle on,
;; returned immediately with `elpaca-queue-limit' nil, and returns with this
;; subscription in place while the throttle stays at 10.
;;
;; The function is private, so check before subscribing: if it is renamed
;; upstream, say so at startup instead of silently restoring the hang, which
;; would only ever show up on the already-degraded path.
;; Deferred until elpaca.el is actually loaded.  On a warm start the installer
;; above only loads elpaca-autoloads, and `elpaca--release-throttled' is
;; private, so it is not autoloaded and `fboundp' is nil at this point: testing
;; it directly here reported the function missing on every start with packages
;; already installed, and skipped the subscription precisely when it was needed.
(with-eval-after-load 'elpaca
  (if (fboundp 'elpaca--release-throttled)
      (elpaca-subscribe 'failed #'elpaca--release-throttled)
    (warn "Elpaca's `elpaca--release-throttled' is gone; `elpaca-queue-limit'
can hang a failing install.  Drop the `elpaca-queue-limit' setting above, or
re-check upstream for the new name.")))

(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Windows cannot always create symlinks.
;; https://www.howtogeek.com/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/
(when (is-windows-p)
  (elpaca-no-symlink-mode))

;; ---------------------------------------------------------------------------
;; use-package support.
;; The explicit `elpaca-wait' below is what installs the `:ensure' handler
;; before the rest of the init file is macro-expanded -- do not drop it as
;; redundant.  `elpaca-menu-extensions' supplies elpaca-use-package with
;; :wait t, and `elpaca-menu-lock-file' -- which precedes it -- currently
;; records :wait t as well, so today the wait would happen either way.  That
;; is a property of the lock file's contents, not a guarantee: regenerating
;; it against a recipe without :wait would silently drop the wait and leave
;; `:ensure' unhandled.  Calling it here does not depend on either menu.

;; `elpaca-use-package-by-default' does not exist in Elpaca; the knob that
;; actually makes `use-package' default to Elpaca is use-package's own
;; `use-package-always-ensure', which Elpaca's :ensure handler then services.
(setq use-package-always-ensure t)
(elpaca elpaca-use-package (elpaca-use-package-mode))
(elpaca-wait)

;; ---------------------------------------------------------------------------
;; Updating

(defun vb/elpaca-update ()
  "Request a reinstall of every package at its current upstream version.
Sets the lock file aside and leaves a marker; the next start deletes the
package tree, installs current versions and records a new lock file for
you to review and commit.

Nothing is removed from the running session -- the tree stays on
`load-path' and intact until Emacs restarts, so an interrupted restart
leaves a working Emacs rather than one whose packages have vanished.

There is no in-place update.  Packages installed from a lock file are
checked out at an exact commit, in detached HEAD: `elpaca-merge-all' runs
\"git merge --ff-only\", which then has no upstream to fast-forward, and
`elpaca-fetch-all' skips every package because a :ref makes
`elpaca-pinned-p' true.  Reinstalling is the whole mechanism.

This re-downloads every package, so expect it to take a while.  To undo,
put elpaca-lock.el.old back (it is kept, and the committed version is in
git) and delete the marker file named in the message."
  (interactive)
  ;; This discards the whole package tree; keep the full-word confirmation
  ;; that `use-short-answers' would otherwise reduce to one keystroke.
  (when (let ((use-short-answers nil))
          (yes-or-no-p "Reinstall every package on next restart? "))
    (let ((marker (expand-file-name "elpaca-reinstall" user-emacs-directory)))
      ;; Move the lock file first.  If that fails (read-only checkout, wrong
      ;; owner) we must not leave a marker behind: the next start would wipe
      ;; the tree and reinstall from the still-present lock, pinning the very
      ;; commits this command exists to replace.
      (when (file-exists-p vb/elpaca-lock-file)
        (rename-file vb/elpaca-lock-file (concat vb/elpaca-lock-file ".old") t))
      (write-region "" nil marker)
      ;; Unconditionally, and before the restart: `restart-emacs' can be
      ;; aborted (C-g at its save prompt), and the marker would then sit armed
      ;; with the user never having been told where it is -- the next ordinary
      ;; start, days later, would wipe the tree unprompted.
      (message "Reinstall armed.  To cancel: delete %s AND move %s.old back."
               marker vb/elpaca-lock-file)
      (when (fboundp 'restart-emacs)
        (restart-emacs)))))


;; ---------------------------------------------------------------------------
(provide 'elpaca-bootstrap)
;;; elpaca-bootstrap.el ends here
