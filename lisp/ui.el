;;; ui.el --- User interface configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Variables

;; Font configuration
(defvar modeline-font "Source Code Pro"
  "Font to use for modeline")
(defvar modeline-font-height 100
  "Height of modeline font")

;; -----------------------------------------------------------------------------
;; Font

(use-package emacs
  :ensure nil
  :config
  (when (display-graphic-p)
  (if (is-font-available-p modeline-font)
    (progn
      (set-face-attribute 'default nil :family modeline-font :height modeline-font-height)
        (log "Applied %s font" modeline-font))
  (error "%s font is not available" modeline-font)))
)

;; -----------------------------------------------------------------------------
;; Theme

(use-package monokai-theme
  ;; TODO: Until PR is merged
  ;; https://github.com/oneKelvinSmith/monokai-emacs/pull/125
  :ensure (:repo "eliaskanelis/monokai-emacs" :branch "master")
  :config
  (setq monokai-user-variable-pitch t)
  (load-theme 'monokai t))

;; -----------------------------------------------------------------------------
;; Modeline

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 0)
  (when (display-graphic-p)
  (if (is-font-available-p modeline-font)
      (progn
        (if (facep 'mode-line-active)
            (set-face-attribute 'mode-line-active nil :family modeline-font :height modeline-font-height)
          (set-face-attribute 'mode-line nil :family modeline-font :height modeline-font-height))
        (set-face-attribute 'mode-line-inactive nil :family modeline-font :height modeline-font-height))
      (error "%s font is not available" modeline-font))))

;; -----------------------------------------------------------------------------
;; Looks
(use-package emacs
  :ensure nil
  :config
  ;; Remove initial scratch message
  (setq initial-scratch-message nil)
  ;; Do not blink cursor
  (blink-cursor-mode -1)
  ;; Disable bell
  (setq ring-bell-function 'ignore)
  
  (setq inhibit-startup-screen t)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  )

;; -----------------------------------------------------------------------------
;; Dim inactive windows
(use-package dimmer
  :ensure t
  :config
  (dimmer-configure-which-key)
  (dimmer-mode t))

;; -----------------------------------------------------------------------------

(provide 'ui)
;;; ui.el ends here