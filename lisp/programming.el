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
(provide 'programming)
;;; programming.el ends here
