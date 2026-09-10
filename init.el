;;; init.el --- Emacs entry point -*- lexical-binding: t; -*-

;;; Commentary:
;; Bootstraps package management, loads modular config, and stores all
;; generated files to cache dir.
;;; Code:

;; ---------------------------------------------------------------------------
;; Environment setup

;; Where this repository lives.  Derived from the file being loaded so that the
;; config works from any location (~/.config/emacs, a checkout, --init-directory).
(defvar init-el-directory
  (file-name-directory (or load-file-name buffer-file-name user-init-file))
  "Directory of this configuration repository.")

;; Redirect Emacs' generated files (backups, auto-saves, etc.) to cache dir,
;; keeping the repository clean.
;; Deliberately hardcoded rather than following XDG_CACHE_HOME: honouring it
;; would relocate an existing install for anyone who sets it, re-cloning every
;; package and orphaning the old tree.
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/"))
;; `make-directory' signals when HOME is unwritable -- e.g. running as a uid
;; with no passwd entry, which makes HOME "/".  The Docker image no longer
;; does that (it creates and chowns /home/tedi and runs as that user), but
;; `docker run --user' or a read-only HOME still can.  Warn rather than signal
;; here, so the cause is named -- but note this only improves the diagnostic:
;; elpaca creates directories under the same path and will abort init shortly
;; afterwards if it is genuinely unwritable.
(condition-case err
    (make-directory user-emacs-directory t)
  (error (warn "Could not create %s (%S); generated files may fail to save"
               user-emacs-directory err)))

;; Prevent customizations from polluting files.
(setq custom-file null-device)

;; Add my lisp/ directory to the load-path.
(add-to-list 'load-path (expand-file-name "lisp" init-el-directory))

;; ---------------------------------------------------------------------------
;; Bootstrap package manager

(require 'elpaca-bootstrap)

;; ---------------------------------------------------------------------------
;; File management and cleanup
(use-package no-littering
  :ensure t
  :demand t
  :config
  ;; Redirect auto-save files
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  ;; Optional: redirect backup files
  (setq backup-directory-alist
        `((".*" . ,(no-littering-expand-var-file-name "backup/")))))

;; ---------------------------------------------------------------------------
;; Core modules
;; Evil first: the leader definers in general-bootstrap bind into evil states,
;; so evil has to exist before those macros are expanded.
(require 'evil-config)
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

;; ---------------------------------------------------------------------------
;; Custom configuration

(require 'ui)

;; ---------------------------------------------------------------------------
;;; init.el ends here
