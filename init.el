 ;;; init.el --- Emacs entry point -*- lexical-binding: t; -*-

;;; Commentary:
;; Bootstraps package management, loads modular config, and stores all
;; generated files to cache dir.
;;; Code:

;; ---------------------------------------------------------------------------
;; Environment setup

;; Redirect Emacs' generated files (backups, auto-saves, etc.) to cache dir.
(setq init-el-directory user-emacs-directory)
(setq user-emacs-directory "~/.cache/emacs/")

;; Prevent customizations from polluting files
(setq custom-file "/dev/null")

;; Add my lisp/ directory to the load-path.
(add-to-list 'load-path (expand-file-name "lisp" init-el-directory))

;; ---------------------------------------------------------------------------
;; Bootstrap package manager

(require 'elpaca-bootstrap)
;; (require 'use-package-bootstrap)  ; alternative

;; ---------------------------------------------------------------------------
;; File management and cleanup
(use-package no-littering
  :ensure t
  :config
  ;; Redirect auto-save files
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  ;; Optional: redirect backup files
  (setq backup-directory-alist
        `((".*" . ,(no-littering-expand-var-file-name "backup/")))))

;; ---------------------------------------------------------------------------
;; Core modules
(require 'general-bootstrap)

;; ---------------------------------------------------------------------------
;; Load modular configuration

(require 'emacs-config)
(require 'voidbuffer)
(require 'minibuffer-config)
(require 'editor)
(require 'version-control)
(require 'notetaking)
(require 'programming)
(require 'utilities)
(require 'sandbox)
;; (require 'examples)

;; ---------------------------------------------------------------------------
;; Custom configuration

(require 'ui)

;; ---------------------------------------------------------------------------
;;; init.el ends here
