;;; minibuffer-config.el --- Minibuffer -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
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

;; ---------------------------------------------------------------------------
;; Minibuffer completion

(use-package vertico
  :custom
  (vertico-count 20) ;; Show that many candidates in one go
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode)
  :general
  (general-define-key
   :keymaps 'vertico-map
   "<up>" 'vertico-previous
   "<down>" 'vertico-next
   "<C-up>" (lambda () (interactive) (dotimes (_ 5) (vertico-previous)))
   "<C-down>" (lambda () (interactive) (dotimes (_ 5) (vertico-next)))))

;; ---------------------------------------------------------------------------
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

;; ---------------------------------------------------------------------------
;; Make the completion fuzzy.

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; ---------------------------------------------------------------------------
;; Search and navigation commands
;;
;; vertico/orderless/marginalia are the completion UI; consult is the set of
;; commands that use it.  This is where the `SPC /', `SPC s *' and `SPC b b'
;; leader keys point, so it has to be loaded -- it previously sat in
;; programming-unused.el, which nothing requires.

(use-package consult
  :ensure t
  :custom
  ;; Narrow with `<' instead of the default `>' -- same key unshifted.
  (consult-narrow-key "<")
  :config
  ;; Live preview while moving through candidates, but not for the ones where
  ;; it means running a grep over the project on every keystroke.
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   :preview-key "M-."))

;; ---------------------------------------------------------------------------
;; Act on whatever is at point or in the minibuffer
;;
;; `C-.' on a candidate, a file name, a URL or a symbol offers the commands
;; that apply to it.  Control-prefixed, so it works in every evil state.

(use-package embark
  :ensure t
  :general
  (general-define-key
   "C-." '(embark-act :wk "Act on target")
   "C-;" '(embark-dwim :wk "Act on target (default)")
   "C-h B" '(embark-bindings :wk "Bindings (completing-read)"))
  :init
  ;; Replace the key help with a completing-read interface.
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Exporting a consult search to a buffer, with preview.  `embark-export' from
;; a `consult-ripgrep' turns the hits into a grep buffer; with wgrep it would
;; be editable, which is not installed yet.
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; ---------------------------------------------------------------------------
(provide 'minibuffer-config)
;;; minibuffer-config.el ends here
