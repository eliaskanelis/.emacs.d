;;; examples.el --- Example code -*- lexical-binding: t; -*-

(require 'core)

;; -----------------------------------------------------------------------------

;; (use-package emacs
;;  :ensure nil
;;  :after (vertico marginalia))

;; -----------------------------------------------------------------------------

;; (defun my-file-git-annotator (file)
;;   "Annotate FILE with Git status."
;;   (let* ((fullpath (expand-file-name file))
;;          (status (shell-command-to-string (format "git -C %s status --short %s"
;;                                                   (file-name-directory fullpath)
;;                                                   (shell-quote-argument fullpath))))
;;          (info (if (string-match "[MADRCU?! ]" status)
;;                    (substring status 0 2)
;;                  "  ")))
;;     (concat (propertize " " 'display '(space :align-to 20))
;;             info)))

;; (add-to-list 'marginalia-annotators
;;              '(file my-file-git-annotator marginalia-annotate-file builtin none))

;; -----------------------------------------------------------------------------

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))




(use-package dirvish
  :ensure t
  :config
  (dirvish-override-dired-mode))


(use-package smart-jump
  :ensure t
  :bind (("C-c ." . smart-jump-go)
         ("C-c ," . smart-jump-back)
         ("C-c ?" . smart-jump-references)))

;; -----------------------------------------------------------------------------

(require 'server)
(unless (server-running-p)
    (log "Starting server")
    (server-start))

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

(if (is-font-available-p "Source Code Pro")
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