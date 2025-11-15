;;; notetaking.el --- Note taking -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------

(setq voidbuffer-org-directory "~/org/")

;; -----------------------------------------------------------------------------

(defun voidbuffer:visit-notes ()
  "Visits my notes"
  (interactive)
  (find-file (concat voidbuffer-org-directory "notes.org")))

(use-package emacs
  :ensure nil
  :general
  (my-keys
    "n" '(voidbuffer:visit-notes :wk "Open notes")))

;; -----------------------------------------------------------------------------

(use-package org
  :ensure t
  :hook (org-mode . org-indent-mode)
  :config
  ;; === Word Processor Style Settings ===
  
  ;; Hide emphasis markers (/, *, =, etc.)
  (setq org-hide-emphasis-markers t)
  
  ;; Better bullets for list items
  (font-lock-add-keywords 'org-mode
    '(("^ +\\([-*]\\) " (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  
  ;; === Header Configuration ===
  
  ;; Use org-bullets for better header appearance
  ;; (let* ((variable-tuple 
  ;;          (cond 
  ;;            ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
  ;;            (nil (warn "Cannot find a Sans Serif font. Install Source Sans Pro."))))
  ;;        (base-font-color (face-foreground 'default nil 'default))
  ;;        (headline `(:inherit default :weight bold :foreground ,base-font-color)))
  ;;   (custom-theme-set-faces 'user
  ;;     `(org-level-8 ((t (,@headline ,@variable-tuple))))
  ;;     `(org-level-7 ((t (,@headline ,@variable-tuple))))
  ;;     `(org-level-6 ((t (,@headline ,@variable-tuple))))
  ;;     `(org-level-5 ((t (,@headline ,@variable-tuple))))
  ;;     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
  ;;     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
  ;;     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
  ;;     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
  ;;     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

;;   (add-hook 'org-mode-hook
;;             (lambda ()
;;               (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;                                            ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;                                            ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;                                            ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                                            (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;                      (base-font-color     (face-foreground 'default nil 'default))
;;                      (headline           '(:inherit default :weight bold)))

;;                 (custom-set-faces
;;                                         '(org-level-8 ((t (,@headline ,@variable-tuple))))
;;                                         '(org-level-7 ((t (,@headline ,@variable-tuple))))
;;                                         '(org-level-6 ((t (,@headline ,@variable-tuple))))
;;                                         '(org-level-5 ((t (,@headline ,@variable-tuple))))
;;                                         '(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1 :foreground "#66d9ef"))))
;;                                         '(org-level-3 ((t (,@headline ,@variable-tuple :height 1.15 :foreground "Yellow"))))
;;                                         '(org-level-2 ((t (,@headline ,@variable-tuple :height 1.25 :foreground "#a6e22e"))))
;;                                         '(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5 :foreground "Orange"))))
;;                                         '(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))

;;                                         '(org-block                 ((t (:inherit fixed-pitch))))
;;                                         '(org-document-info         ((t (:foreground "Red"))))
;;                                         '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;                                         '(org-link                  ((t (:foreground "#a6e22e" :underline t))))
;;                                         '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;                                         '(org-property-value        ((t (:inherit fixed-pitch))) t)
;;                                         '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;                                         '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;                                         '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))
;;                                         '(org-indent                ((t (:inherit (org-hide fixed-pitch)))))
;;                                         '(org-table                 ((t (:inherit (org-hide fixed-pitch)))))
;;                                         ;; check if this works
;;                                         '(org-comment               ((t (:inherit (org-hide fixed-pitch) :height 0.8))))

;;                                         ))
;;               ))

  ;; === Display Settings ===
  
  ;; Show ellipsis with arrow instead of dots
  (setq org-ellipsis " ")
  
  ;; === Source Code Block Settings ===
  
  ;; Syntax highlight in code blocks
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-window-setup 'current-window)
  (setq org-src-preserve-indentation t)
  
  ;; Prettier code block delimiters
  (setq org-fontify-whole-block-delimiter-line t)
  
  ;; === Babel (Code Execution) Settings ===
  
  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-results-keyword "results")
  (setq org-babel-default-inline-header-args
    '((:results . "replace")
      (:exports . "both")))
  (setq org-babel-default-header-args
    '((:session . "none")
      (:results . "replace")
      (:exports . "both")
      (:cache . "no")
      (:noweb . "no")
      (:hlines . "no")
      (:tangle . "no")
      (:padnewline . "yes")))
  
  ;; Enable code execution for multiple languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (sql . t)
     (sqlite . t)
     (R . t)
     (ruby . t)))
  
  ;; === Export Settings ===
  
  (setq org-export-with-smart-quotes t)
  (setq org-cycle-include-plain-lists 'integrate)
  
  ;; === Keybindings ===
  :general
  (my-keys
    :keymaps '(org-mode-map org-agenda-mode-map)
    "o" '(:ignore t :wk "org")
    "o a" '(org-agenda :wk "agenda")
    "o c" '(org-capture :wk "capture")
    "o e" '(org-babel-execute-buffer :wk "execute buffer")
    "o b" '(org-babel-execute-subtree :wk "execute block")
    "o l" '(org-insert-link :wk "insert link")
    "o t" '(org-todo :wk "toggle todo")))

;; Optional: Use org-bullets for even nicer headers
(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("●" "○" "◉" "◎")))

;; -----------------------------------------------------------------------------
;; Zettelkasten

;; Fast note insertion for a smoother writing flow
;;
;; Sometimes while writing, you’ll want to create a new node in your Org Roam
;; notes without interrupting your writing flow! Typically you would use
;; org-roam-node-insert, but when you create a new note with this command,
;; it will open the new note after it gets created.
;;
;;  We can define a function that enables you to create a new note and insert
;; a link in the current document without opening the new note’s buffer.
;;
;; This will allow you to quickly create new notes for topics you’re mentioning
;; while writing so that you can go back later and fill those notes in with
;; more details!
(defun voidbuffer:org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))


(use-package org-roam
  :ensure t
  :commands org-roam db-sync
  :general
  (my-keys
    "f" '(org-roam-node-find :wk "List my atomic notes")
    "v" '(org-roam-node-random :wk "Open a random note"))
  (my-keys
    :keymaps '(org-mode-map org-agenda-mode-map)
    "l" '(org-roam-buffer-toggle :wk "org-roam-buffer-toggle")
    "i" '(org-roam-node-insert :wk "Insert note")
    "a" '(voidbuffer:org-roam-node-insert-immediate :wk "Insert intermediate note")
    "o" '(org-roam-ui-open :wk "Open UI")
    "o" '(org-roam-tag-add :wk "Add tag")
    "o" '(org-roam-tag-remove :wk "Remove tag")
	;; ("C-c d t" . '(org-roam-dailies-goto-today :wk "Open today")
	;; ("C-c d p" . '(org-roam-dailies-goto-previous-note :wk "Go to previous")
	;; ("C-c d n" . '(org-roam-dailies-goto-next-note :wk "Go to next")
	;; ("C-c v" . '(my/org-capture-fleeting :wk "Capture fleeting note")
    )
    :init
    (require 'org-roam-dailies) ;; Ensure the keymap is available
    ;; Publish org-roam
    (require 'org-roam-export)

    :config
    ;;(require 'org-roam-dailies) ;; Ensure the keymap is available
    ;; Publish org-roam
    ;;(require 'org-roam-export)

    ;; This is where all my notes will be
    (setq org-roam-directory "~/org/roam")

    ;; This is where all my dailies will be. Relative to org-roam's directory.
    (setq org-roam-dailies-directory "daily/")

    ;; I want completion.
    (setq org-roam-completion-everywhere t)

    ;; Display the org-roam note type in the mini-buffer.
    ;; I created my own type
    (cl-defmethod org-roam-node-type ((node org-roam-node))
      "Return the TYPE of NODE."
      (condition-case nil
          ;; We want to allow files being on the outer directory.
          (if (string-match-p "/" (file-relative-name (org-roam-node-file node) org-roam-directory))
              ;; It is a file in the folder structure.
              (car (split-string (file-relative-name (org-roam-node-file node) org-roam-directory) "/" ))
            ;; It is a file in the outer directory.
            "/")
        (error "?")))

    ;; This is what is shown in the minibuffer
    (setq org-roam-node-display-template
          (concat "${type:15} ${title:60} " (propertize "${tags:20}" 'face 'org-tag)))

    ;; My templates for new notes
    (setq org-roam-capture-templates
          '(
            ("f" "fleeting" plain
             (file "~/.config/emacs/templates/org-roam/default.org")
             :if-new (file+head "fleeting/%<%Y-%m-%d_%H:%M:%S>-${slug}.org" "#+title: ${title}\n#+filetags: :draft:\n")
             :unnarrowed t)
            ("p" "persistent" plain
             (file "~/.config/emacs/templates/org-roam/default.org")
             :if-new (file+head "persistent/%<%Y-%m-%d_%H:%M:%S>-${slug}.org" "#+title: ${title}\n#+filetags: :draft:\n")
             :unnarrowed t)
            ("b" "blog post" plain
             (file "~/.config/emacs/templates/org-roam/default.org")
             :if-new (file+head "blog/%<%Y>/%<%m>/${slug}.org" "#+title: ${title}\n#+filetags: :draft:\n")
             :immediate-finish t
             :unnarrowed t)
            ("l" "literature" plain
             (file "~/.config/emacs/templates/org-roam/default.org")
             :if-new (file+head "literature/${title}.org" "#+title: ${title}\n#+filetags: :draft:\n")
             :immediate-finish t
             :unnarrowed t)
            ))

    ;; Template for org-roam dailies.
    (setq org-roam-dailies-capture-templates
          '(
            ;; TODO: There is a bug with reading the template file.
            ("d" "default" entry
             (file "~/.config/emacs/templates/org-roam/daily.org")
             :target (file+head "%<%Y-%m-%d>.org"
                                "#+title: %<%Y-%m-%d>\n"))
            ))

    ;; Configuring what is displayed in the buffer
    (setq org-roam-mode-sections
          '(org-roam-backlinks-section
            org-roam-reflinks-section
            org-roam-unlinked-references-section
            ))

    ;; Org-roam backlinks always to the right
    (add-to-list 'display-buffer-alist
                 '("\\*org-roam\\*"
                   (display-buffer-in-direction)
                   (direction . right)
                   (window-width . 0.33)
                   (window-height . fit-window-to-buffer)))

    ;;(org-roam-setup)
    ;; Update the database only if the org roam directory exists
    (when (file-directory-p org-roam-directory)
      (org-roam-db-autosync-enable)))

;; -----------------------------------------------------------------------------
;; Org roam UI

; Dependency of org-roam-ui
(use-package websocket
  :after org-roam)

(use-package org-roam-ui
  :after org-roam
  ;; Normally we'd recommend hooking orui after org-roam, but since org-roam
  ;; does not have a hookable mode anymore, you're advised to pick something
  ;; yourself.
  ;; If you don't care about startup time, use:
  ;; :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t)
  (org-roam-ui-follow-mode))

;; -----------------------------------------------------------------------------
(provide 'notetaking)
;;; notetaking.el ends here