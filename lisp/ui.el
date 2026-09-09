;;; ui.el --- User interface configuration -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Variables

;; Font configuration
(defvar modeline-font "Source Code Pro"
  "Font to use for the default face and the modeline.")
(defvar modeline-font-height 100
  "Height of `modeline-font', in 1/10 pt.")

;; ---------------------------------------------------------------------------
;; Font

(defun vb/apply-font (face)
  "Set FACE to `modeline-font'.
Silent about a missing font -- `vb/apply-fonts' checks that once for all
faces, so a daemon client frame does not warn three times per frame."
  (when (and (display-graphic-p) (facep face))
    (set-face-attribute face nil
                        :family modeline-font
                        :height modeline-font-height)
    (vb/log "Applied %s font to %s" modeline-font face)))

(defvar vb/font-warning-issued nil
  "Non-nil once a missing `modeline-font' has been reported.")

(defun vb/apply-fonts ()
  "Apply `modeline-font' to the default and modeline faces.
Safe to call before doom-modeline loads: `vb/apply-font' skips faces that
do not exist yet.  A missing font is reported once per session -- this runs
from `server-after-make-frame-hook', so warning per call would pop
*Warnings* on every daemon client frame forever."
  (when (display-graphic-p)
    (if (not (is-font-available-p modeline-font))
        (unless vb/font-warning-issued
          (setq vb/font-warning-issued t)
          (warn "Font `%s' is not available; keeping the default" modeline-font))
      (vb/apply-font 'default)
      ;; `mode-line-active' only exists since Emacs 29; fall back to `mode-line'.
      (vb/apply-font (if (facep 'mode-line-active) 'mode-line-active 'mode-line))
      (vb/apply-font 'mode-line-inactive))))

(use-package emacs
  :ensure nil
  :config
  (vb/apply-fonts)
  ;; Under `emacs --daemon' there is no graphical frame during init, so
  ;; `display-graphic-p' is nil and nothing is applied -- including
  ;; doom-modeline's faces, whose :config also runs frameless.  Re-apply all of
  ;; them when the first client frame appears.
  (add-hook 'server-after-make-frame-hook #'vb/apply-fonts))

;; ---------------------------------------------------------------------------
;; Show minibuffer in the center

;;(use-package vertico-posframe
;;  :after vertico
;;  :ensure t
;;  :custom
;;  (vertico-posframe-mode 1)
;;  (vertico-posframe-parameters
;;   '((left-fringe . 8)
;;     (right-fringe . 8))))

;; ---------------------------------------------------------------------------
;; Minimal UI + centered text
(use-package olivetti
  :hook ((text-mode . olivetti-mode)
         (prog-mode . olivetti-mode)
	 (org-mode . olivetti-mode))
  :custom
  ;; WARNING! Visual bug with 'display-fill-column-indicator-mode'
  ;; if number is small.
  (olivetti-body-width 90))

;; ---------------------------------------------------------------------------
;; Golden ratio

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1))

;; ---------------------------------------------------------------------------
;; Theme

(use-package monokai-theme
  ;; TODO: Until PR is merged
  ;; https://github.com/oneKelvinSmith/monokai-emacs/pull/125
  :ensure (:host github :repo "eliaskanelis/monokai-emacs" :branch "master")
  :config
  (setq monokai-user-variable-pitch t)
  (load-theme 'monokai t))

;; ---------------------------------------------------------------------------
;; Modeline

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (vb/apply-fonts))

;; ---------------------------------------------------------------------------
;; Looks
(use-package emacs
  :ensure nil
  :custom
  ;; Sane and minimalistic settings.
  ;; (startup screen, bell and cursor blink are handled in emacs-config.el)
  (initial-scratch-message nil) ;; Remove initial scratch message
  :config
  ;; Minimalism.  Neither `tool-bar-mode' nor `scroll-bar-mode' exists in a
  ;; terminal build; `menu-bar-mode' always does.
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (menu-bar-mode -1)
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1)))

;; ---------------------------------------------------------------------------
;; Dim inactive windows
(use-package dimmer
  :ensure t
  :config
  (dimmer-configure-which-key)
  (dimmer-mode t))

;; ---------------------------------------------------------------------------

(provide 'ui)
;;; ui.el ends here
