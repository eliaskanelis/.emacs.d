;;; minibuffer-config.el --- Minibuffer -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Emacs minibuffer configurations.

(use-package emacs
  :ensure nil
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; -----------------------------------------------------------------------------
;; Minibuffer completion

(use-package vertico
  :custom
  (vertico-count 20) ;; Show that many candidates in one go
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; -----------------------------------------------------------------------------
;; Minibuffer rich annotations

(use-package marginalia
  :init
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away.
  ;; Note that this forces loading the package.
  (marginalia-mode)
  :config
  (general-define-key
    ;; To make the binding available in the *Completions* buffer,
    ;; add it to the 'completion-list-mode-map'.
    :keymaps 'minibuffer-local-map
    "M-TAB" '(marginalia-cycle :wk "Cycle annotations")))

;; -----------------------------------------------------------------------------
;; Make the completion fuzzy.

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; -----------------------------------------------------------------------------
(provide 'minibuffer-config)
;;; minibuffer-config.el ends here