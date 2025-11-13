;;; examples.el --- Example code -*- lexical-binding: t; -*-

(require 'core)

;; -----------------------------------------------------------------------------



;; -----------------------------------------------------------------------------

(require 'server)
(unless (server-running-p)
    (log "Starting server")
    (server-start))

;; -----------------------------------------------------------------------------

;; GUI vs CLI font setup
(when (and (display-graphic-p)      ;; GUI check
           (font-available-p "Source Code Pro"))  ;; font exists
  (set-face-attribute 'default nil :family "Source Code Pro" :height 100)
  (log "Applied Source Code Pro font"))

;;------------------------------------------------------------------------------

;; We need to load org early because we use it with org-babel
(use-package org
  :ensure t)

;; -----------------------------------------------------------------------------

(when (is-linux-p)
  (log "Linux-specific feature enabled"))

(when (is-windows-p)
  (log "Windows-specific feature enabled"))

(if (display-graphic-p (selected-frame))
    (log "GUI at startup")
  (log "CLI/terminal at startup"))

(if (display-graphic-p)
    (log "Running in GUI")
  (log "Running in terminal/CLI"))

(if (executable-find "git")
    (log "Git is available")
  (log "Git is not installed"))

;; (unless (executable-find "gitas")
;;   (log "Git is required, exiting...")
;;   (kill-emacs 1))

(if (font-available-p "Source Code Pro")
    (log "Found font")
  (log "Could not find font"))

;; -----------------------------------------------------------------------------

;; ;; Load the rest from a modular config
;; (load (expand-file-name "config.el" user-emacs-directory) t)

;; -----------------------------------------------------------------------------

;; (use-package mock-package
;;   :init
;;   (log "mock-package :init called")
;;   ;; simulate a hook
;;   (add-hook 'after-init-hook (lambda () (log "mock-package after-init-hook running")))

;;   :config
;;   (log "mock-package :config called")

;;   :hook
;;   ((prog-mode . (lambda () (log "mock-package prog-mode hook fired")))
;;    (text-mode . (lambda () (log "mock-package text-mode hook fired")))))

;; ;; ---------------------------------------------------------------------------
;; ;; Set the garbage collection early to load faster.
;; ;; We will set it back at the end of the init.el
;; (setq gc-cons-threshold (* 50 1000 1000))

;; ;; ---------------------------------------------------------------------------
;; ;; Show startup time in minibuffer

;; (defun my/display-startup-time ()
;;   (message "Emacs loaded in %s with %d garbage collections."
;;            (format "%.2f seconds"
;;                    (float-time
;;                    (time-subtract after-init-time before-init-time)))
;;            gcs-done))

;; (add-hook 'emacs-startup-hook #'my/display-startup-time)

;; ;; ---------------------------------------------------------------------------
;; ;; Install Elpaca Package manager


;; ;; ----------------------------------------------------------------------------

;; ;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; ;; reliably, set `user-emacs-directory` before loading no-littering!

;; (use-package no-littering
;;   :ensure t
;;   :config
;;   ;; no-littering doesn't set this by default so we must place
;;   ;; auto save files in the same path as it uses for sessions
;;   (setq auto-save-file-name-transforms
;; 	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

;;------------------------------------------------------------------------------

(defun my/load-custom-config (&optional config-file)
  "Load a custom Emacs configuration file.

  This function takes the name of a custom configuration file (e.g., 'config.org')
  and loads it using Org Babel's `org-babel-load-file`. The file is expected
  to be located in the user's Emacs configuration directory.

  Args:
  - CONFIG-FILE (optional): The name of the custom configuration file (e.g., 'config.org').
    If not provided, it defaults to 'config.org'.

  The `init-el-directory` variable specifies the location of the user's Emacs
  configuration directory. The function checks if the specified configuration
  file exists and is readable before loading it.
  "
  (interactive)
  (let ((default-config-file "config.org")
        (custom-config-file (expand-file-name
                             (or config-file default-config-file) init-el-directory)))
    (when (file-readable-p custom-config-file)
      (org-babel-load-file custom-config-file))))

;; Load the main function
;; (my/load-custom-config "config.org")

;; ;; ----------------------------------------------------------------------------
;; ;; Make gc pauses faster by decreasing the threshold.
;; (setq gc-cons-threshold (* 2 1000 1000))

;; -----------------------------------------------------------------------------

(provide 'examples)
;;; examples.el ends here