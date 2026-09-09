;;; early-init.el --- Pre-GUI, pre-package initialisation -*- lexical-binding: t; -*-

;;; Commentary:
;; Emacs loads this before `package.el' and before the first frame exists.
;; NOTE: the file must be named `early-init.el'; a dotted name is never read.
;;; Code:

;; We use elpaca, not package.el.
(setq package-enable-at-startup nil)

;; Debugging: opt in with `EMACS_DEBUG=1 emacs'.
;; Enabling these unconditionally makes every ordinary signal (file-missing,
;; end-of-buffer, ...) pop the debugger and stops Emacs from starting.
;; Declared, not required: warnings.el is not loaded this early, and a bare
;; setq would be an assignment to a free variable.  warnings.el defines it with
;; defcustom, which will not clobber a value already set here.
(defvar warning-minimum-level)

(when (member (getenv "EMACS_DEBUG") '("1" "t" "yes" "true"))
  ;; Deliberately not `debug-on-signal': that calls the debugger "regardless of
  ;; condition handlers", so every signal elpaca, magit or org handles
  ;; internally would stop Emacs.  `debug-on-error' is what yields a usable
  ;; backtrace for errors that are actually unhandled.
  (setq debug-on-error t
        warning-minimum-level :debug))

;;; early-init.el ends here
