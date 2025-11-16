;;; programming.el --- Programming utilities -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Sane configs

(use-package emacs
  :ensure nil
  :init
  ;; Highlight current line
  ;; It only looks good in GUI mode
  (when window-system (add-hook 'prog-mode-hook 'hl-line-mode)))

;; -----------------------------------------------------------------------------
;; Smart movement

(use-package mwim
  :ensure t
  :general
  (general-define-key
   :keymaps 'prog-mode-map
   "C-a" '(mwim-beginning-of-code-or-line-or-comment :wk "Cursor to the start of line (smart)")
   "C-e" '(mwim-end-of-code-or-line :wk "Cursor to the end of line (smart)")))

;; -----------------------------------------------------------------------------
;; Highlight TODO, FIXME....

(use-package hl-todo
  :ensure t
  :custom
  (hl-todo-keyword-faces
   '(("TODO"   . (:foreground "#F92672" :background "#3E3D32" :weight bold))
     ("FIXME"  . (:foreground "#F92672" :background "#3E3D32" :weight bold))
     ("DEBUG"  . (:foreground "#AE81FF" :background "#3E3D32" :weight bold))
     ("STUB"   . (:foreground "#66D9EF" :background "#3E3D32" :weight bold))))
  :hook ((prog-mode . hl-todo-mode)))

;; -----------------------------------------------------------------------------
;; Visible indentation

(use-package indent-bars
  :custom
  (indent-bars-no-descend-lists t)
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  :hook ((prog-mode . indent-bars-mode)))

;; -----------------------------------------------------------------------------
(provide 'programming)
;;; programming.el ends here
