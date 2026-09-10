;;; version-control.el --- Version control config -*- lexical-binding: t; -*-

;;; Commentary:
;; Mainly configuring git utilities.
;;; Code:

;; ---------------------------------------------------------------------------
;; We need git

;; Elpaca already needs git to have got this far, so this is only a diagnostic.
;; Killing Emacs here would leave the user with no way to fix the problem.
(unless (executable-find "git")
  (warn "Git not found in `exec-path'; magit and elpaca will not work"))

;; ---------------------------------------------------------------------------
;; Version control diff highlighter

(use-package diff-hl
  :ensure t
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         ;; diff-hl-magit-pre-refresh became an alias for `ignore' in 1.11.0.
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  ;; Show diff indicators in the left fringe
  (setq diff-hl-side 'left)
  ;; Customize the appearance
  (setq diff-hl-draw-borders nil)  ;; Don't draw borders around indicators
  :init
  ;; Enable on-the-fly mode for all buffers with diff-hl
  (diff-hl-flydiff-mode)
  )

;; ---------------------------------------------------------------------------
;; Magit

(use-package transient
  :ensure t)

;; RET takes to INDEX
;; C-RET takes to Working Tree
(use-package magit
  :ensure t
  :after transient
  :custom
  ;; Highlight word changes in diffs (more readable)
  (magit-diff-highlight-hunk-body t)
  (magit-diff-paint-whitespace t)
  ;; Auto-refresh magit buffer when files change on disk
  (magit-refresh-status-buffer t)
  :init
  (setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
  :general
  (my-keys
    "g" '(:ignore t :wk "Git")
    "g g" '(magit-status :wk "Magit status")))

;; ---------------------------------------------------------------------------
;; TODOs in magit

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

;; ---------------------------------------------------------------------------
;; Git timemachine

(use-package git-timemachine
  :ensure t
  :general
  (my-keys
    "g h" '(git-timemachine :wk "Git timemachine (toggle)"))
  :custom
  (git-timemachine-show-minibuffer-details t))

;; ---------------------------------------------------------------------------
;; Sideline blamer

(use-package sideline-blame
  :ensure t
  :hook (prog-mode . sideline-mode)
  :custom
  (sideline-blame-commit-format " • %s")
  (sideline-blame-author-format "%s, ")
  (sideline-blame-datetime-format "%d-%b-%Y ")
  :init
  (setq sideline-backends-right '((sideline-blame . up)))
  )

;; ---------------------------------------------------------------------------
;; Browse at remote

(use-package browse-at-remote
  :ensure (:host github :repo "eliaskanelis/browse-at-remote")
  :general
  (my-keys
    "g r" '(browse-at-remote :wk "Browse at remote"))
  :config
  ;; Tell browse-at-remote that kentavros.lan uses Gitea
  (add-to-list 'browse-at-remote-remote-type-regexps
               '(:host "kentavros\\.lan$" :type "gitea" :actual-host "git.kentavros.lan"))
  )

;; ---------------------------------------------------------------------------
(provide 'version-control)
;;; version-control.el ends here
