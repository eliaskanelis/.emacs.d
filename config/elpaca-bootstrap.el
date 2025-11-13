;;; elpaca-bootstrap.el --- Elpaca package manager bootstrap -*- lexical-binding: t; -*-

;; https://github.com/progfolio/elpaca

(require 'core)

;; ---------------------------------------------------------------------------
;; Prefer stable repositories

(setq elpaca-repos
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

		;; ("melpa-stable" . "https://stable.melpa.org/packages/")

;; -----------------------------------------------------------------------------
;; Install Elpaca Package manager

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
							  ;; Additionally installed extensions
                              :files (:defaults "elpaca-test.el" "extensions/*")
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
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
(add-hook 'after-init-hook #'elpaca-process-queues)

;; Additionally log
(add-hook 'elpaca-after-init-hook
          (lambda ()
            (log "Elpaca finished initializing.")))

;; Windows does not support symlinks
(when (is-windows-p)
  ;; https://www.howtogeek.com/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/
  (elpaca-no-symlink-mode))

(elpaca `(,@elpaca-order))

;; Use elpaca with use-package by default
(setq use-package-always-ensure t
      use-package-always-ensure-function #'elpaca)

;; -----------------------------------------------------------------------------

;; Make `use-package` forms use Elpaca by default
(with-eval-after-load 'elpaca
  (elpaca-use-package-mode))

;; TODO: Is this needed?
;; Block until current queue processed.
;; (elpaca-wait)
;; (log "Elpaca unblocked.")

;; -----------------------------------------------------------------------------
(provide 'elpaca-bootstrap)
;;; elpaca-bootstrap.el ends here