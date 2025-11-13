;;; use-package-bootstrap.el --- Built-in package manager bootstrap -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Install Elpaca Package manager

(setq inhibit-startup-message t
      native-comp-async-report-warnings-errors 'silent
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Prefer newer elisp byte-compiled files
(setq load-prefer-newer t)

;; Bootstrap package.el
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")
        ))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -----------------------------------------------------------------------------
(provide 'use-package-bootstrap)
;;; use-package-bootstrap.el ends here