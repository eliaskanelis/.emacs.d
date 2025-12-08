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
(provide 'utilities)
;;; utilities.el ends here
