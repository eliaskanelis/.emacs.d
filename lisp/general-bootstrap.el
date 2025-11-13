;;; general-bootstrap.el --- General keybindings bootstrap -*- lexical-binding: t; -*-

;; https://github.com/noctuid/general.el

;; -----------------------------------------------------------------------------

(use-package general
  :config

  ;; Ignore global keys
  (general-define-key
    "C-z" '(ignore :wk "disabled")      ; Disable suspend
	)

  ;; Project scope
  (general-define-key
    :prefix "C-,"
    "b" '((lambda () (interactive) (message "Build")) :wk "Build project")
    "d" '((lambda () (interactive) (message "Compile")) :wk "Debud project"))

  ;; Custom scope
  (general-define-key
    :prefix "C-c"

    ;; File operations
    "f f" '(find-file :wk "Find file")
    "f s" '(save-buffer :wk "Save file")
    "f r" '(revert-buffer :wk "Revert file")
    "f d" '(dired :wk "Open dired")

    ;; Buffer operations
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-buffer :wk "Kill buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b l" '(list-buffers :wk "List buffers")

    ;; Window operations
    "w w" '(other-window :wk "Other window")
    "w s" '(split-window-below :wk "Split horizontally")
    "w v" '(split-window-right :wk "Split vertically")
    "w d" '(delete-window :wk "Delete window")
    "w m" '(delete-other-windows :wk "Maximize window")

    ;; Search and replace
    "s s" '(isearch-forward :wk "Search forward")
    "s r" '(query-replace :wk "Query replace")

    ;; Help
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h k" '(describe-key :wk "Describe key")
    "h m" '(describe-mode :wk "Describe mode")

    ;; Quit/Exit
    "q q" '(save-buffers-kill-terminal :wk "Quit Emacs")))

(provide 'general-config)

;; -----------------------------------------------------------------------------

(use-package which-key
  :init (which-key-mode)
  :custom (which-key-idle-delay 0.3))

;; -----------------------------------------------------------------------------
(provide 'general-bootstrap)
;;; general-bootstrap.el ends here