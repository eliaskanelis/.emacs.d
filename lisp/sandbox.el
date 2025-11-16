;;; sandbox.el --- Sandboxing -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Better syntax highlighting

(use-package tree-sitter
  :ensure t
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;; -----------------------------------------------------------------------------
(provide 'sandbox)
;;; sandbox.el ends here