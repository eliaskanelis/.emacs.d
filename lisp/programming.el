;;; programming.el --- Programming utilities -*- lexical-binding: t; -*-

;;; Commentary:
;; C/C++, Rust, Python and Docker, on Emacs' native stack: treesit for
;; parsing, eglot for LSP, flymake for diagnostics, corfu + cape for
;; completion.
;;
;; This replaces the lsp-mode / lsp-ui / lsp-pyright / flycheck set that sat
;; unused in programming-unused.el.  eglot and flymake ship with Emacs and
;; already know clangd, rust-analyzer and pyright, so the same result costs
;; four fewer packages.  To go back: install lsp-mode, lsp-ui and lsp-pyright,
;; swap `eglot-ensure' for `lsp-deferred' in the hooks below and point the
;; `gd'/`gr'/`K' bindings at `lsp-find-definition' and friends.  The one real
;; loss is lsp-ui's sideline, which has no eglot equivalent.
;;
;; Every language exposes the same local-leader verbs, so the keys mean the
;; same thing whatever the buffer:
;;
;;   SPC m b  build      SPC m r  run     SPC m l  lint
;;   SPC m d  debug      SPC m t  test
;;; Code:

;; ---------------------------------------------------------------------------
;; Sane configs

(use-package emacs
  :ensure nil
  :hook
  (
   ;; Display line numbers
   (prog-mode . display-line-numbers-mode)
   ;; Highlight current line
   ;; It only looks good in GUI mode
   (prog-mode . (lambda () (when window-system (hl-line-mode 1)))))
  :config
  (add-hook 'prog-mode-hook
            (lambda ()
              (setq display-fill-column-indicator-column 79)
              (display-fill-column-indicator-mode 1))))

;; ---------------------------------------------------------------------------
;; Tree-sitter
;;
;; The grammars are compiled on the machine, not shipped: treesit-auto offers
;; to fetch and build one the first time a buffer needs it, and remaps e.g.
;; c-mode to c-ts-mode only once that grammar exists.  Without a grammar the
;; classic mode keeps working, so this can never leave a language unusable.

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; ---------------------------------------------------------------------------
;; LSP
;;
;; Both the treesit and the classic mode are hooked: which one a file gets
;; depends on whether its grammar is installed yet.

(use-package eglot
  :ensure nil
  :hook ((c-mode c-ts-mode
          c++-mode c++-ts-mode
          rust-mode rust-ts-mode
          python-mode python-ts-mode) . eglot-ensure)
  :custom
  ;; Eglot's own doc buffer is enough; the echo area flicker is not worth it.
  (eglot-autoshutdown t)
  (eglot-extend-to-xref t)
  :config
  ;; Neovim's LSP keys.  `gd' and `K' already exist in evil (xref and man
  ;; page); inside an eglot buffer they should mean what they mean in neovim.
  (general-define-key
   :states '(normal visual)
   :keymaps 'eglot-mode-map
   "gd" '(xref-find-definitions :wk "Goto definition")
   "gr" '(xref-find-references :wk "References")
   "gi" '(eglot-find-implementation :wk "Goto implementation")
   "K"  '(eldoc-doc-buffer :wk "Hover docs")
   ;; `[' and `]' are already prefixes in evil, so these just extend them.
   "]d" '(flymake-goto-next-error :wk "Next diagnostic")
   "[d" '(flymake-goto-prev-error :wk "Previous diagnostic"))
  (my-keys
    "c" '(:ignore t :wk "Code")
    "c a" '(eglot-code-actions :wk "Code action")
    "c r" '(eglot-rename :wk "Rename")
    "c f" '(eglot-format :wk "Format")
    "c d" '(flymake-show-buffer-diagnostics :wk "Diagnostics")
    "c D" '(flymake-show-project-diagnostics :wk "Project diagnostics")))

;; ---------------------------------------------------------------------------
;; In-buffer completion

(use-package corfu
  :ensure t
  :general
  (general-define-key
    :keymaps 'corfu-map
    "TAB" 'corfu-next
    "<backtab>" 'corfu-previous)
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 0)
  :init
  (global-corfu-mode))

(use-package cape
  :ensure t
  ;; Every Cape command under a mnemonic prefix; `C-c p ?' lists them.
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; The order matters: the first function returning a result wins.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; ---------------------------------------------------------------------------
;; Visible indentation

(use-package indent-bars
  :ensure t
  :custom
  (indent-bars-no-descend-lists t)
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  :hook ((prog-mode . indent-bars-mode)))

;; ---------------------------------------------------------------------------
;; Highlight TODO, FIXME....

(use-package hl-todo
  :ensure t
  :custom
  (hl-todo-keyword-faces
   '(("TODO"   . (:foreground "#F92672" :background "#3E3D32" :weight bold))
     ("FIXME"  . (:foreground "#F92672" :background "#3E3D32" :weight bold))
     ("DEBUG"  . (:foreground "#AE81FF" :background "#3E3D32" :weight bold))
     ("STUB"   . (:foreground "#66D9EF" :background "#3E3D32" :weight bold))))
  :hook ((prog-mode . hl-todo-mode)))

;; ---------------------------------------------------------------------------
;; C / C++
;;
;; `compile' is the whole build story: no project.el integration, no cmake
;; package, no compilation abstraction.  `SPC m b' reruns whatever
;; `compile-command' says, which for C defaults to make.

;; Two blocks, not one: `c-mode-map' comes from cc-mode and `c-ts-mode-map'
;; from c-ts-mode, and a keymap cannot be bound before the file defining it is
;; loaded.  `:general' inside a `use-package' defers the binding until that
;; package loads; a single call naming maps from two packages cannot.

(use-package cc-mode
  :ensure nil
  :general
  (programmer-keys
    :keymaps '(c-mode-map c++-mode-map)
    "b" '(compile :wk "make")
    "r" '((lambda () (interactive) (compile "make run")) :wk "make run")
    "t" '((lambda () (interactive) (compile "make test")) :wk "make test")
    "l" '(flymake-show-buffer-diagnostics :wk "Diagnostics")
    "d" '(gdb :wk "gdb")))

(use-package c-ts-mode
  :ensure nil
  :custom
  (c-ts-mode-indent-offset 4)
  (c-ts-mode-indent-style 'linux)
  :general
  (programmer-keys
    :keymaps '(c-ts-mode-map c++-ts-mode-map)
    "b" '(compile :wk "make")
    "r" '((lambda () (interactive) (compile "make run")) :wk "make run")
    "t" '((lambda () (interactive) (compile "make test")) :wk "make test")
    "l" '(flymake-show-buffer-diagnostics :wk "Diagnostics")
    "d" '(gdb :wk "gdb")))

;; ---------------------------------------------------------------------------
;; Rust
;;
;; `rust-ts-mode' is built in; no rust-mode, no rustic, no cargo.el.  Cargo is
;; a command line, and `compile' runs command lines.

(use-package rust-ts-mode
  :ensure nil
  :mode "\\.rs\\'"
  :general
  (programmer-keys
    :keymaps 'rust-ts-mode-map
    "b" '((lambda () (interactive) (compile "cargo build")) :wk "cargo build")
    "r" '((lambda () (interactive) (compile "cargo run")) :wk "cargo run")
    "t" '((lambda () (interactive) (compile "cargo test")) :wk "cargo test")
    "l" '((lambda () (interactive) (compile "cargo clippy")) :wk "cargo clippy")
    "f" '((lambda () (interactive) (compile "cargo fmt")) :wk "cargo fmt")))

;; ---------------------------------------------------------------------------
;; Python

(use-package python
  :ensure nil
  :custom
  ;; eglot picks pyright out of `eglot-server-programs' automatically when it
  ;; is on PATH; nothing to configure for it here.
  (python-indent-guess-indent-offset nil)
  (python-shell-interpreter "python3")
  :general
  (programmer-keys
    :keymaps '(python-mode-map python-ts-mode-map)
    "r" '(run-python :wk "REPL")
    "b" '(python-shell-send-buffer :wk "Send buffer to REPL")
    "t" '((lambda () (interactive) (compile "python3 -m pytest")) :wk "pytest")
    "l" '(flymake-show-buffer-diagnostics :wk "Diagnostics")))

;; ---------------------------------------------------------------------------
;; Docker
;;
;; `SPC d' is a transient over containers, images, volumes and compose --
;; start, stop, logs, shell, prune -- without leaving Emacs.

(use-package docker
  :ensure t
  :general
  (my-keys
    "d" '(docker :wk "Docker")))

(use-package dockerfile-mode
  :ensure t)

;; No docker-compose-mode: a compose file is YAML, and treesit-auto already
;; sends .yml/.yaml to `yaml-ts-mode'.  The package only added keyword
;; completion for compose's own schema, which eglot does better anyway once
;; yaml-language-server is on PATH.

;; ---------------------------------------------------------------------------
;; Markdown

;; Registers its own `auto-mode-alist' entries via autoloads, so installing
;; it is all that is needed to enable it.
(use-package markdown-mode
  :ensure t)

;; ---------------------------------------------------------------------------
(provide 'programming)
;;; programming.el ends here
