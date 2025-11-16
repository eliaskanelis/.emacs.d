;;; emacs-config.el --- Emacs configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Print Emacs startup time statistics

(use-package emacs
  :ensure nil
  :init
  (defun print-startup-time ()
    "Print how long Emacs took to start."
    (log "Emacs loaded in %.3f seconds with %d garbage collections."
         (float-time (time-subtract after-init-time before-init-time))
         gcs-done)
    (message "Emacs loaded in %.3f seconds with %d garbage collections."
             (float-time (time-subtract after-init-time before-init-time))
             gcs-done))
  (add-hook 'emacs-startup-hook #'print-startup-time))

;; -----------------------------------------------------------------------------
;; Print on hook invocation

(add-hook 'emacs-startup-hook (lambda () (log "[HOOK] emacs-startup-hook!")))

;; -----------------------------------------------------------------------------

(use-package emacs
  :ensure nil
  :custom
  ;; Start in text mode. Not elisp mode.
  (initial-major-mode 'text-mode)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Remove default startup screen.
  (inhibit-startup-message t)
  ;; (native-comp-async-report-warnings-errors 'silent)
  ;; Disables backup files (the ~ files).
  (make-backup-files nil)
  ;; Disables auto-saving.
  (auto-save-default nil)
  ;; Disables lock files.
  (create-lockfiles nil)

  ;; Do not blink cursor.
  (blink-cursor-mode -1)
  ;; Disable bell.
  (ring-bell-function 'ignore)
  ;; Blindly follow symlinks without asking me.
  (vc-follow-symlinks nil)
  ;; Change yes-or-no questions into y-or-n questions.
  (defalias 'yes-or-no-p 'y-or-n-p)
  ;; Auto refresh file if changed outside.
  (global-auto-revert-mode t)
  )

;; -----------------------------------------------------------------------------
;; Persist history over Emacs restarts.

(use-package savehist
  :ensure nil
  :init
  (savehist-mode))

;; -----------------------------------------------------------------------------
;; Window movement

(use-package emacs
  :ensure nil
  :general
  (general-define-key
  ;; Move between windows
  "C-S-<up>"   'windmove-up
  "C-S-<down>" 'windmove-down
  "C-S-<right>" 'windmove-right
  "C-S-<left>" 'windmove-left
  ;; Swap the windows with each other
  "C-M-<up>"   'windmove-swap-states-up
  "C-M-<down>" 'windmove-swap-states-down
  "C-M-<right>" 'windmove-swap-states-right
  "C-M-<left>" 'windmove-swap-states-left))

;; -----------------------------------------------------------------------------
(provide 'emacs-config)
;;; emacs-config.el ends here
