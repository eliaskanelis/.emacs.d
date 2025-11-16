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

(use-package monokai-pro-theme
  :ensure t
  :init
  ;; TODO: Change according to Xresources
  (defvar monokai-pro-classic-theme-colors
  '(;; Background and foreground colors
    :bg     "#272821"
    :bg+1   "#3b3c35"
    :bg+2   "#57584f"
    :fg-4   "#6e7066"
    :fg-3   "#919288"
    :fg-2   "#abaca0"
    :fg-1   "#fdfff1"
    :fg     "#fefff8"

    ;; General colors
    :white  "#ffffff"
    :red    "#f82570"
    :orange "#fc961f"
    :yellow "#e4db73"
    :green  "#a6e12d"
    :blue   "#66d9ee"
    :purple "#ae81ff"
    :pink   "#f82570"

    ;; Colors from the original Monokai colorschemes. Some of these are used
    ;; rarely as highlight colors. They should be avoided if possible.
    :orig-red     "#f92672"
    :orig-orange  "#fd971f"
    :orig-yellow  "#e6db74"
    :orig-green   "#a6e22e"
    :orig-cyan    "#a1efe4"
    :orig-blue    "#66d9ef"
    :orig-violet  "#ae81ff"
    :orig-magenta "#fd5ff0"))
  :config
  (load-theme 'monokai-pro-classic t))

;; -----------------------------------------------------------------------------
;; Modeline

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  
  :config
  (setq doom-modeline-height 0) ; optional
  (if (is-font-available-p modeline-font)
      (progn
        (if (facep 'mode-line-active)
            (set-face-attribute 'mode-line-active nil :family modeline-font :height modeline-font-height)
          (set-face-attribute 'mode-line nil :family modeline-font :height modeline-font-height))
        (set-face-attribute 'mode-line-inactive nil :family modeline-font :height modeline-font-height))
    (error "%s font is not available" modeline-font)))

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