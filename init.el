;;; init.el --- entry point -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Bootstrap

;; Prevent customisations to the end of this file.
(setq custom-file "/dev/null")

;; Add config directory to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Put the generated files in the cache directory
(setq init-el-directory user-emacs-directory)
(setq user-emacs-directory "~/.cache/emacs")

;; Load modules

;; We select elpaca
(require 'elpaca-bootstrap)
;; (require 'use-package-bootstrap)

(require 'general-bootstrap)

(require 'emacs-config)
(require 'voidbuffer)
(require 'minibuffer-config)
(require 'editor)
(require 'notetaking)
(require 'sandbox)
;; (require 'examples)

;; -----------------------------------------------------------------------------
;; Custom configuration

(require 'ui)

;;------------------------------------------------------------------------------
;; End of init.el
;;
