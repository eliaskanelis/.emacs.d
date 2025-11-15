;;; use-package-bootstrap.el --- Built-in package manager bootstrap -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Use-package configuration

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