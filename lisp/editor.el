;;; editor.el --- Editor configuration -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Sane configs

(use-package emacs
  :ensure nil
  :init
  ;; Set UTF-8 encoding
  (setq locale-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

  ;; Make urls clickable
  (global-goto-address-mode 1)
  ;; Makes selected text get deleted when you start typing.
  (delete-selection-mode 1)
  ;; Emacs treats camelCase strings as a single word by default,
  ;; this changes said behaviour.
  (global-subword-mode 1)
  :custom
  ;; Hide the cursor in inactive windows.
  (cursor-in-non-selected-windows nil)
  :config
  ;; Modeline
  (line-number-mode 1)     ;; Show line numbers in the modeline
  (column-number-mode 1)   ;; Show column number in the modeline
  (size-indication-mode 1)) ;; Show the file size in the modeline

;; ---------------------------------------------------------------------------
;; Expand region

(use-package expand-region
  :ensure t
  :general
  (general-define-key
    "C-="    'er/expand-region
    "C--"    'er/contract-region))

;; ---------------------------------------------------------------------------
;; Move line or selection up or down

(use-package move-text
  :ensure t
  :general
  (general-define-key
    "M-<up>" 'move-text-up
    "M-<down>" 'move-text-down))

;; ---------------------------------------------------------------------------
;; Scrolling
(use-package emacs
  :ensure nil
  :config
  (pixel-scroll-precision-mode 1)
  :custom
  (scroll-conservatively 101)
  (scroll-preserve-screen-position t))

;; ---------------------------------------------------------------------------
;; Crux

(use-package crux
  :ensure t
  :general
  (my-keys
    "d" '(crux-duplicate-current-line-or-region :wk "Duplicate current line")
    "k" '(crux-kill-other-buffers :wk "Kill all other buffers")
    "x" '(crux-open-with :wk "Open with external program")))

;; ---------------------------------------------------------------------------
(provide 'editor)
;;; editor.el ends here
