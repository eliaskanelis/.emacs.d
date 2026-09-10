;;; general-bootstrap.el --- General keybindings bootstrap -*- lexical-binding: t; -*-

;; https://github.com/noctuid/general.el

;;; Commentary:
;; Two leaders, as in neovim:
;;
;;   SPC    global.  Available in normal, visual and motion state everywhere,
;;          including dired, magit and help buffers.
;;   SPC m  major-mode local.  Same key in every language, each mode fills it
;;          in.  Bound in the mode's own keymap, never globally.
;;
;; `SPC' is bound in `override', i.e. general's keymap inside
;; `emulation-mode-map-alists', which sits above every major and minor mode
;; map.  No mode can shadow it.  Only prefixes go there: overriding a single
;; key globally would break the modes that own it.
;;
;; `my-keys' is used from every module in lisp/, so the prefix lives here and
;; only here -- changing it moves every binding in the configuration at once.
;;; Code:

(use-package general
  :ensure t
  :config

  ;; The `override' keymap only takes effect while this is on.
  (general-override-mode 1)

  (general-create-definer my-keys
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")

  ;; The local leader is `SPC m', not `,'.  `,' is vim's reverse-`;' (repeat
  ;; f/t backwards) and stays that way: a bound key cannot become a prefix, so
  ;; using it would mean unbinding a real vim motion first.
  ;;
  ;; ALWAYS call this with `:keymaps <some-mode-map>'.  It has no default
  ;; keymap on purpose -- a global binding here would sit in `override' and
  ;; shadow every mode-local binding under the same key, which is the opposite
  ;; of a local leader.  Prefix keymaps merge across precedence levels, so
  ;; `SPC' from `my-keys' and `SPC m x' from a mode map coexist.
  ;;
  ;; The contract every mode fills in, so the same key means the same verb in
  ;; every language:
  ;;
  ;;   SPC m b  build      SPC m r  run     SPC m l  lint
  ;;   SPC m d  debug      SPC m t  REPL / test
  (general-create-definer programmer-keys
    :states '(normal visual motion)
    :prefix "SPC m")

  ;; NOTE: everything below must be a command that actually exists in a
  ;; running Emacs.  consult, embark and dirvish are configured in
  ;; examples.el / programming-unused.el, which init.el does NOT load, so they
  ;; are not installed -- binding `consult-buffer' here would give a key that
  ;; reports "void function".  Built-ins are used instead; swap them for the
  ;; consult commands in the same breath as loading those modules.

  (my-keys
    ;; Label only -- the bindings under it come from each major mode, see
    ;; `programmer-keys' above.  Without this which-key shows a bare "m".
    "m" '(:ignore t :wk "local (mode)")
    ;; Top level: the two things reached most often, one keystroke past SPC.
    "SPC" '(find-file :wk "Find file")
    "," '(switch-to-buffer :wk "Switch buffer")
    "/" '(project-find-regexp :wk "Search project"))

  (my-keys
    ;; File operations
    "f" '(:ignore t :wk "File operations")
    "f f" '(find-file :wk "Find file")
    "f s" '(save-buffer :wk "Save file")
    "f r" '(revert-buffer :wk "Revert file")
    "f d" '(dired :wk "Open dired"))

  (my-keys
    ;; Buffer operations
    "b" '(:ignore t :wk "Buffer operations")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-current-buffer :wk "Kill buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b l" '(ibuffer :wk "List buffers"))

  (my-keys
    ;; Window operations.  Evil's own `C-w' prefix works too; this is the
    ;; discoverable copy, since which-key lists it.
    "w" '(:ignore t :wk "Window operations")
    "w w" '(other-window :wk "Other window")
    "w s" '(split-window-below :wk "Split horizontally")
    "w v" '(split-window-right :wk "Split vertically")
    "w d" '(delete-window :wk "Delete window")
    "w m" '(delete-other-windows :wk "Maximize window"))

  (my-keys
    ;; Search and replace.  In-buffer search is vim's `/'; these are the
    ;; project-wide equivalents of telescope.
    "s" '(:ignore t :wk "Search and replace")
    "s s" '(isearch-forward :wk "Search buffer")
    "s g" '(project-find-regexp :wk "Grep project")
    "s i" '(imenu :wk "Jump to symbol")
    "s r" '(query-replace :wk "Query replace"))

  (my-keys
    ;; Help
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h k" '(describe-key :wk "Describe key")
    "h m" '(describe-mode :wk "Describe mode"))

  (my-keys
    ;; Quit/Exit
    "q q" '(save-buffers-kill-terminal :wk "Quit Emacs")))

;; CRITICAL: Wait for general to load before using :general keyword
(elpaca-wait)

;; ---------------------------------------------------------------------------

(use-package which-key
  :init (which-key-mode)
  :custom (which-key-idle-delay 0.3))

;; ---------------------------------------------------------------------------
(provide 'general-bootstrap)
;;; general-bootstrap.el ends here
