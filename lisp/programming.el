;;; programming.el --- Programming utilities -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Sane configs

(use-package emacs
  :ensure nil
  :hook
  (
   ;; Display line numbers
   (prog-mode . display-line-numbers-mode)
   ;; Highlight current line
   ;; It only looks good in GUI mode
   (prog-mode . (lambda () (when window-system (hl-line-mode 1)))))
  :config
  (add-hook 'prog-mode-hook
            (lambda ()
              (setq display-fill-column-indicator-column 79)
              (display-fill-column-indicator-mode 1))))

;; ---------------------------------------------------------------------------
;; Smart movement

(use-package mwim
  :ensure t
  :general
  (general-define-key
   :keymaps 'prog-mode-map
   "C-a" '(mwim-beginning-of-code-or-line-or-comment :wk "Cursor to the start of line (smart)")
   "C-e" '(mwim-end-of-code-or-line :wk "Cursor to the end of line (smart)")))

;; ---------------------------------------------------------------------------
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

;; ---------------------------------------------------------------------------
;;

;; (use-package newcomment
;;   :ensure t
;;   :bind (:map
;;          prog-mode-map
;;          ;; Better comment functionality
;;          ;; https://emacsredux.com/blog/2020/06/10/comment-commands-redux/
;;          ("M-;" . 'comment-line)
;;          ("C-M-;" . 'comment-line)))

;; ---------------------------------------------------------------------------
;; Hungry deletion

;; Backspace or Delete will get rid of all whitespace until the next
;; non-whitespace character is encountered.
(use-package hungry-delete
  :ensure t
  :general
  (general-define-key
   :keymaps 'prog-mode-map
   "<backspace>" 'hungry-delete-backward
   "<delete>" 'hungry-delete-forward)
  :custom
;;   (hungry-delete-chars-to-skip " \t\n\r")
  (hungry-delete-chars-to-skip " \t"))

;; ---------------------------------------------------------------------------
;; Agressive indent

;; (use-package aggressive-indent
;;   :ensure t
;;   :hook (prog-mode . aggressive-indent-mode))

;; ---------------------------------------------------------------------------
;; LSP

(use-package lsp-mode
  :hook ((c-mode          ; clangd
          c++-mode        ; clangd
          c-or-c++-mode   ; clangd
          java-mode       ; eclipse-jdtls
          js-mode         ; ts-ls (tsserver wrapper)
          js-jsx-mode     ; ts-ls (tsserver wrapper)
          typescript-mode ; ts-ls (tsserver wrapper)
          python-mode     ; pyright
          web-mode        ; ts-ls/HTML/CSS
          haskell-mode    ; haskell-language-server
          ) . lsp-deferred)
  :commands lsp
  :general
  (general-define-key
    :keymaps 'lsp-mode-map
    "C-c l d" 'lsp-find-definition
    "C-c l r" 'lsp-find-references
    "C-c l i" 'lsp-find-implementation)
  :config
  (setq lsp-auto-guess-root t)
;;   (setq lsp-log-io nil)
;;   (setq lsp-restart 'auto-restart)
;;   (setq lsp-enable-symbol-highlighting nil)
;;   (setq lsp-enable-on-type-formatting nil)
;;   (setq lsp-signature-auto-activate nil)
;;   (setq lsp-signature-render-documentation nil)
;;   (setq lsp-eldoc-hook nil)
;;   (setq lsp-modeline-code-actions-enable nil)
;;   (setq lsp-modeline-diagnostics-enable nil)
;;   (setq lsp-headerline-breadcrumb-enable nil)
;;   (setq lsp-semantic-tokens-enable nil)
;;   (setq lsp-enable-folding nil)
;;   (setq lsp-enable-imenu nil)
  (setq lsp-enable-snippet nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5))

;; ---------------------------------------------------------------------------

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-border (face-foreground 'default))
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-delay 0.05))

;; ---------------------------------------------------------------------------
;; Python

(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :init (when (executable-find "python3")
          (setq lsp-pyright-python-executable-cmd "python3")))


(use-package corfu
  :hook ((lsp-mode . corfu-mode)
         (org-mode . corfu-mode))
  :general
  (general-define-key
    :keymaps 'corfu-map
    "TAB" 'corfu-next
    "<backtab>" 'corfu-previous)
  :custom
  (corfu-cycle t)
  :config
  (setq corfu-auto t)
  (setq corfu-auto-delay 0.2)
  (setq corfu-auto-prefix 0))



;; Add extensions
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)




(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))


;; (use-package ellama
;;   :ensure t
;;   :bind ("C-c e" . ellama)
;;   ;; send last message in chat buffer with C-c C-c
;;   :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
;;   :init (setopt ellama-auto-scroll t)
;;   :config
;;   ;; show ellama context in header line in all buffers
;;   (ellama-context-header-line-global-mode +1)
;;   ;; show ellama session id in header line in all buffers
;;   (ellama-session-header-line-global-mode +1))


(use-package fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))


(use-package consult
  :ensure t)
;;   :bind (("C-c f" . consult-find)
;;          ("C-c b" . consult-buffer)
;;          ("C-c g" . consult-grep)))

;; (use-package codemetrics
;;   :ensure (codemetrics 
;;            :host github 
;;            :repo "jcs-elpa/codemetrics")
;;   :config
;;   (setq codemetrics-enable t)
;;   (add-hook 'treesit-major-mode-setup-hook 'codemetrics-mode))


;; ---------------------------------------------------------------------------
;; Visible indentation

(use-package indent-bars
  :custom
  (indent-bars-no-descend-lists t)
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  :hook ((prog-mode . indent-bars-mode)))


;; (use-package git-gutter-fringe+
;;   :bind
;;   (("C-c m d" . git-gutter+-show-hunk-inline-at-point)
;;    ("C-c m p" . git-gutter+-previous-hunk)
;;    ("C-c m n" . git-gutter+-next-hunk))
;;   :init
;;   (global-git-gutter+-mode))

;; ---------------------------------------------------------------------------
(provide 'programming)
;;; programming.el ends here
