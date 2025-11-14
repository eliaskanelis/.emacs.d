;;; editor.el --- Editor configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Crux

(use-package crux
  :ensure t
  :general
  (my-keys
    "d" '(crux-duplicate-current-line-or-region :wk "Duplicate current line")
    "k" '(crux-kill-other-buffers :wk "Kill all other buffers")
    "o" '(crux-open-with :wk "Open with external program")))

;; -----------------------------------------------------------------------------
(provide 'editor)
;;; editor.el ends here