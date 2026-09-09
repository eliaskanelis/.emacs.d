;;; general-bootstrap.el --- General keybindings bootstrap -*- lexical-binding: t; -*-

;; https://github.com/noctuid/general.el

;; ---------------------------------------------------------------------------

(use-package general
  :ensure t
  :config

  (global-unset-key (kbd "C-z"))
  (general-create-definer my-z-leader
    :prefix "C-z")

  (general-create-definer my-keys
    :prefix "C-c")

  (general-create-definer programmer-keys
    :prefix "C-,")

  (programmer-keys
	"b" '((lambda () (interactive) (message "Build")) :wk "Build")
	"d" '((lambda () (interactive) (message "Debug")) :wk "Debug")
	"r" '((lambda () (interactive) (message "Run")) :wk "Run")
	"t" '((lambda () (interactive) (message "REPL")) :wk "REPL")
	"l" '((lambda () (interactive) (message "Lint")) :wk "Lint"))

  (my-z-leader
    "f" '(find-file :wk "find file")
    "b" '(switch-to-buffer :wk "switch buffer"))

  (my-keys
    ;; File operations
    "f" '(:ignore t :wk "File operations")
    "f f" '(find-file :wk "Find file")
    "f s" '(save-buffer :wk "Save file")
    "f r" '(revert-buffer :wk "Revert file")
    "f d" '(dired :wk "Open dired"))

  (my-keys
    ;; Buffer operations
    "b" '(:ignore t :wk "Buffer operations")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-buffer :wk "Kill buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b l" '(list-buffers :wk "List buffers"))

  (my-keys
    ;; Window operations
    "w" '(:ignore t :wk "Window operations")
    "w w" '(other-window :wk "Other window")
    "w s" '(split-window-below :wk "Split horizontally")
    "w v" '(split-window-right :wk "Split vertically")
    "w d" '(delete-window :wk "Delete window")
    "w m" '(delete-other-windows :wk "Maximize window"))

  (my-keys
    ;; Search and replace
    "s" '(:ignore t :wk "Search and replace")
    "s s" '(isearch-forward :wk "Search forward")
    "s r" '(query-replace :wk "Query replace"))

  (my-keys
    ;; Help
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h k" '(describe-key :wk "Describe key")
    "h m" '(describe-mode :wk "Describe mode"))

  (my-keys
    ;; Quit/Exit
    "q q" '(save-buffers-kill-terminal :wk "Quit Emacs")))

;; CRITICAL: Wait for general to load before using :general keyword
(elpaca-wait)

;; ---------------------------------------------------------------------------

(use-package which-key
  :init (which-key-mode)
  :custom (which-key-idle-delay 0.3))

;; ---------------------------------------------------------------------------
(provide 'general-bootstrap)
;;; general-bootstrap.el ends here
