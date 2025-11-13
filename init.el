;;; init.el --- entry point -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Bootstrap

;; Prevent customisations to the end of this file.
(setq custom-file "/dev/null")

;; Add config directory to load-path
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;; Put the generated files in the cache directory
(setq init-el-directory user-emacs-directory)
(setq user-emacs-directory "~/.cache/emacs")

;; Load modules
(require 'core)
(log "Starting Emacs!")

;; We select elpaca
(require 'elpaca-bootstrap)
;; (require 'use-package-bootstrap)

(require 'general-bootstrap)

;; -----------------------------------------------------------------------------
;; Custom configuration

(require 'ui)

;; -----------------------------------------------------------------------------

(defun print-startup-time ()
  "Print how long Emacs took to start."
  (log "Emacs loaded in %.3f seconds with %d garbage collections."
           (float-time (time-subtract after-init-time before-init-time))
           gcs-done)
  (message "Emacs loaded in %.3f seconds with %d garbage collections."
           (float-time (time-subtract after-init-time before-init-time))
           gcs-done))

(add-hook 'emacs-startup-hook #'print-startup-time)

;;------------------------------------------------------------------------------
;; End of init.el
;;
