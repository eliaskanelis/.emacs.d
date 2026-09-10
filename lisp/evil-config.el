;;; evil-config.el --- Vim emulation -*- lexical-binding: t; -*-

;;; Commentary:
;; Modal editing, always on.  Loaded before `general-bootstrap' because the
;; leader definers there bind into evil states, which requires evil to exist
;; when those macros are expanded.
;;
;; Nothing here uses the `:general' keyword for the same reason -- general is
;; not loaded yet, so bindings in this file use evil's own `evil-define-key'.
;;
;; Deliberately NOT done: binding <escape> globally to `keyboard-escape-quit'.
;; In a terminal ESC is the Meta prefix, so that breaks `M-x' and every other
;; Meta key under `emacs -nw'.
;;; Code:

;; ---------------------------------------------------------------------------
;; Evil
;;
;; The `evil-want-*' and `evil-search-module' variables are read while evil
;; loads, so they go in `:init'.  In `:custom' they are set too late and
;; silently do nothing -- a classic cause of "I set it and it ignored me".

(use-package evil
  :ensure t
  :init
  ;; Must be nil BEFORE evil loads, otherwise evil installs its own bindings
  ;; for other packages and evil-collection's are ignored.
  (setq evil-want-keybinding nil)
  ;; `C-u' scrolls like vim instead of being the prefix argument.  The prefix
  ;; argument is still on `C-U' (shifted) and `M-1'..`M-9'.
  (setq evil-want-C-u-scroll t)
  ;; `C-i' jumps forward in the jumplist, as vim's `<Tab>' does.
  (setq evil-want-C-i-jump t)
  ;; `Y' yanks to end of line.  Classic vi made `Y' a synonym for `yy'; this is
  ;; the neovim default and what fingers usually expect.
  (setq evil-want-Y-yank-to-eol t)
  ;; Vim's own `/' search: incremental, with `n'/`N', search offsets and
  ;; `:substitute' highlighting.  The default ('isearch) reuses Emacs isearch,
  ;; which behaves subtly differently under repeat and in macros.
  (setq evil-search-module 'evil-search)
  :custom
  ;; Emacs 28+ has real undo/redo built in; this is why undo-tree is not here.
  (evil-undo-system 'undo-redo)
  ;; `j'/`k' move by screen line in wrapped buffers (org, markdown).
  (evil-respect-visual-line-mode t)
  ;; `:split' / `:vsplit' open below and to the right and move point into the
  ;; new window, as vim does.
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  ;; Neovim's default `incsearch'+`hlsearch' pairing: matches stay lit until
  ;; the next search.  `:nohl' clears them.
  (evil-ex-search-persistent-highlight t)
  :config
  (evil-mode 1))

;; ---------------------------------------------------------------------------
;; Evil bindings for everything else
;;
;; Hand-rolling normal-state keys for magit, dirvish, help and the rest is far
;; more code than this one dependency.  org is excluded: evil-org below does a
;; better job, and letting both bind org keys means they fight over TAB.

(use-package evil-collection
  :ensure t
  :after evil
  :custom
  (evil-collection-setup-minibuffer nil) ;; the minibuffer stays modeless
  :config
  (setq evil-collection-mode-list (delq 'org evil-collection-mode-list))
  (evil-collection-init))

;; ---------------------------------------------------------------------------
;; Vim behaviour that evil leaves out
;;
;; Each of these is a key already in vim muscle memory, not a new capability.
;; evil-collection does not cover them.

;; `cs"'', `ds(', `ysiw]' -- vim-surround.
(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

;; `gcc' / `gc{motion}' -- vim-commentary.  Wraps Emacs' own comment commands.
(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode 1))

;; `*' and `#' on a visual selection, rather than only the word under point.
(use-package evil-visualstar
  :ensure t
  :after evil
  :config
  (global-evil-visualstar-mode 1))

;; `%' jumps between matching keywords and tags, not just parentheses.
(use-package evil-matchit
  :ensure t
  :after evil
  :config
  (global-evil-matchit-mode 1))

;; Flashes the text an operator acted on.  This is neovim's highlight-on-yank,
;; extended to delete, change and paste.
(use-package evil-goggles
  :ensure t
  :after evil
  :custom
  (evil-goggles-duration 0.1)
  :config
  (evil-goggles-mode 1))

;; `[3/17]' next to the search prompt, which neovim shows by default.
;; doom-modeline renders anzu's state, so this needs no extra configuration.
(use-package evil-anzu
  :ensure t
  :after evil
  :config
  (global-anzu-mode 1))

;; Vim bindings for org structure: `M-h'/`M-l' promote and demote, `M-j'/`M-k'
;; move subtrees, `o' opens the next heading or list item, and `dae'/`dar' treat
;; an element and a subtree as text objects.
(use-package evil-org
  :ensure t
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; `C-a' / `C-x' increment and decrement the number under point.  This is a
;; core vim key that evil genuinely does not implement.
(use-package evil-numbers
  :ensure t
  :after evil
  :config
  (evil-define-key '(normal visual) 'global
    (kbd "C-a") #'evil-numbers/inc-at-pt
    ;; `C-x' is Emacs' most important prefix, so the decrement goes on `g C-x'
    ;; rather than shadowing it.  Vim's `C-x' is unreachable here.
    (kbd "g C-x") #'evil-numbers/dec-at-pt))

;; ---------------------------------------------------------------------------
;; Neovim feel that is not an evil package

(use-package emacs
  :ensure nil
  :custom
  ;; `relativenumber'.  `display-line-numbers-mode' itself is enabled for
  ;; prog-mode in programming.el; this only changes what it counts.
  (display-line-numbers-type 'relative)
  ;; `scrolloff=8': keep this many lines of context above and below point.
  (scroll-margin 8))

(elpaca-wait)

;; ---------------------------------------------------------------------------
;; Did it actually turn on?
;;
;; Elpaca wraps every `:config' body in `condition-case-unless-debug', so an
;; error in the forms above degrades to a line in *Warnings* and `evil-mode' is
;; simply never enabled -- an Emacs that looks completely normal.  Say so
;; loudly instead, since "no visible change" is indistinguishable from "this
;; file was never loaded".

(if (bound-and-true-p evil-mode)
    (vb/log "Evil is active")
  (warn "evil-config.el ran but `evil-mode' is off.
Check *Warnings* and M-x elpaca-log for the package that failed."))

;; ---------------------------------------------------------------------------
(provide 'evil-config)
;;; evil-config.el ends here
