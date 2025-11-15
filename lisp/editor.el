;;; editor.el --- Editor configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; Sane configs

(use-package emacs
  :ensure nil
  :init
  ;; Makes selected text get deleted when you start typing.
  (delete-selection-mode 1)
  ;; Emacs treats camelCase strings as a single word by default,
  ;; this changes said behaviour.
  (global-subword-mode 1))

;; -----------------------------------------------------------------------------
;; Expand region

(use-package expand-region
  :ensure t
  :general
  (general-define-key
    "C-="    'er/expand-region
    "C--"    'er/contract-region))

;; -----------------------------------------------------------------------------
;; Crux

(use-package crux
  :ensure t
  :general
  (my-keys
    "d" '(crux-duplicate-current-line-or-region :wk "Duplicate current line")
    "k" '(crux-kill-other-buffers :wk "Kill all other buffers")
    "o" '(crux-open-with :wk "Open with external program")))

;; -----------------------------------------------------------------------------
(provide 'editor)
;;; editor.el ends here