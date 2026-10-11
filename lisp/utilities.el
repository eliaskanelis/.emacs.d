;;; utilities.el --- Utilities -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; fzf

(use-package fzf
  :general
  (my-keys
    "s d" '(fzf :wk "Search file in directory")
    "s p" '(fzf-git :wk "Search file in project"))
  :config
  (setq fzf/args "-x --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15))

;; ---------------------------------------------------------------------------
;; Dired, rebuilt
;;
;; `dirvish-override-dired-mode' means every `dired' call gets dirvish, so no
;; separate binding is needed: `SPC f d' and `-' both land here.

(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-attributes '(vc-state file-size))
  :general
  (general-define-key
   :states '(normal)
   :keymaps 'dirvish-mode-map
   "q" '(dirvish-quit :wk "Quit")
   "TAB" '(dirvish-subtree-toggle :wk "Toggle subtree")))

;; ---------------------------------------------------------------------------
;; Per-project indentation from .editorconfig
;;
;; Built into Emacs 30; the package is harmless there and required before it.

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; ---------------------------------------------------------------------------
;; Server
;;
;; So `emacsclient' -- and `git commit' with EDITOR=emacsclient -- reuses this
;; Emacs instead of starting a second one.

;; `noninteractive' guard: test-startup.sh and the Docker build load this file
;; in batch mode, where a server socket is pointless and outlives the process.
(use-package server
  :ensure nil
  :config
  (unless (or noninteractive (server-running-p))
    (vb/log "Starting server")
    (server-start)))

;; ---------------------------------------------------------------------------
(provide 'utilities)
;;; utilities.el ends here
