;;; emacs-config.el --- Emacs configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Print Emacs startup time statistics

(use-package emacs
  :ensure nil  ;; Don't try to install it
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
  :ensure nil  ;; Don't try to install it
  :custom
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; -----------------------------------------------------------------------------
;; Persist history over Emacs restarts.

(use-package savehist
  :ensure nil  ;; Don't try to install it
  :init
  (savehist-mode))

;; -----------------------------------------------------------------------------
;; Window movement

(use-package emacs
  :ensure nil  ;; Don't try to install it
  :general
  (general-define-key
  ;; Move between windows
  "S-<up>"   'windmove-up
  "S-<down>" 'windmove-down
  "S-<right>" 'windmove-right
  "S-<left>" 'windmove-left
  ;; Swap the windows with each other
  "M-<up>"   'windmove-swap-states-up
  "M-<down>" 'windmove-swap-states-down
  "M-<right>" 'windmove-swap-states-right
  "M-<left>" 'windmove-swap-states-left))

;; -----------------------------------------------------------------------------
(provide 'emacs-config)
;;; emacs-config.el ends here
