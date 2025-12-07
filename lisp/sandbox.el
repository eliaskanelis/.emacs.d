;;; sandbox.el --- Sandboxing -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Better syntax highlighting

(unless (featurep 'treesit)
  (log "Tree-sitter NOT available"))


;; (use-package tree-sitter
;;   :ensure t
;;   :hook (tree-sitter-after-on . tree-sitter-hl-mode)
;;   :config
;;   (global-tree-sitter-mode))

;; ---------------------------------------------------------------------------
;; Treesit with prebuilt grammars

;; (use-package tree-sitter-langs
;;   :ensure t
;;   :after treesit)


;; (use-package treesit-auto
;;   :ensure (:repo "emacs-tree-sitter/tree-sitter-langs"
;;            :files (:defaults "langs"))
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))


;; ---------------------------------------------------------------------------
;; Lisp parenthesis aid

;;(use-package paredit
;;  :ensure t
;;  :hook ((emacs-lisp-mode . paredit-mode)
;;         (lisp-mode . paredit-mode)
;;         (clojure-mode . paredit-mode)))

;; ---------------------------------------------------------------------------
;; Snippets

;; (use-package yasnippet
;;   :ensure t
;;   :init
;;   (yas-global-mode 1)
;;   :custom
;;   (yas-snippet-dirs (list (concat init-el-directory "snippets")))
;;   :config
;;   (add-hook 'yas-minor-mode-hook
;;     (lambda ()
;;       (add-hook 'completion-at-point-functions
;;                 #'cape-yasnippet nil t))))

;; ---------------------------------------------------------------------------

(provide 'sandbox)

;;; sandbox.el ends here
