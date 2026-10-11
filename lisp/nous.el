;;; nous.el --- an Emacs client for Nous  -*- lexical-binding: t; -*-

;; REQ-102: a client needs nothing but the binary.  Clients provide the
;; experience, not the concepts.  Everything here is a call to the `nous'
;; binary; this file holds no idea of what an entity, an identity or a
;; reference is, and learns about new domains by asking.
;;
;; The one thing a client must know is that a Nous reference is rooted at the
;; *Nous root* rather than at the filesystem root: `/note/bee-log.md' is not an
;; absolute path.  `nous resolve' turns it into one, which is why that command
;; exists (REQ-102's Constraints).
;;
;; Install: (add-to-list 'load-path "/path/to/nous/clients/emacs") (require 'nous)

;;; Code:

(require 'flymake)
(require 'subr-x)   ; string-trim, string-empty-p, string-join — used since the first version
(require 'seq)      ; seq-remove, seq-find, seq-filter
(require 'json)     ; json-read-from-string, for an Emacs with no native parser

(defgroup nous nil "An external brain." :group 'external)

(defcustom nous-program "nous"
  "The nous executable."
  :type 'string :group 'nous)

(defcustom nous-vault nil
  "A vault to work in when the current buffer is not in one.
Every call runs in the buffer's own directory, so a vault file always
means its own vault and an inherited domain is found the same way it is
from a shell.  A buffer that is visiting no file — *scratch*, a report,
whatever Emacs opened with — has only the directory it inherited, which may
be nowhere near a vault, and then nous says it is not in one.  Set this to
the vault those buffers should mean; nil leaves the inherited directory,
which is right whenever Emacs was started in a vault."
  :type '(choice (const :tag "Whatever directory the buffer inherited" nil)
                 directory)
  :group 'nous)

(defun nous--run (&rest args)
  "Run nous with ARGS in the current buffer's directory; return stdout.
The directory is what decides which vault answers, exactly as it does in a
shell — `nous-vault' is the fallback for a buffer that is visiting no file.
Signal with the command's own message when it fails, because nous is
already careful to say what went wrong and why.

Stdout and stderr are kept apart, because stdout is the answer and stderr is
what the person needs to know about it (REQ-104).  Merged — which is what
`call-process' does when told to write both to one buffer — a warning is a
listing row that is not one, and in `--format json' it is not JSON at all:
a vault whose roster names a domain nothing answers to says so on every
command (REQ-308), so `show --format json' stopped parsing and completion
quietly stopped answering with nothing said.  A command that worked and
still had something to say is shown, which is where that warning belongs."
  (let ((errors (make-temp-file "nous-err")))
    (unwind-protect
        (with-temp-buffer
          (let* ((default-directory (or (and buffer-file-name
                                             (file-name-directory buffer-file-name))
                                        (and nous-vault (file-name-as-directory
                                                         (expand-file-name nous-vault)))
                                        default-directory))
                 (status (apply #'call-process nous-program nil (list t errors) nil args))
                 (said (string-trim (with-temp-buffer
                                      (insert-file-contents errors)
                                      (buffer-string)))))
            (unless (eq status 0)
              (user-error "%s" (if (string-empty-p said)
                                   (string-trim (buffer-string))
                                 said)))
            (unless (string-empty-p said)
              (message "%s" said))
            (buffer-string)))
      (delete-file errors))))

(defun nous--lines (out)
  "OUT split into non-empty lines, each split on tabs."
  (mapcar (lambda (l) (split-string l "\t"))
          (seq-remove #'string-empty-p (split-string out "\n"))))

(defun nous--resolved (ref)
  "What `resolve' says REF names, as (IDENTITY PATH), or nil.
One command answers both halves and this client reads neither out of
anything else: an identity is what `resolve' returns, not a shape a client
knows how to recognise (REQ-102)."
  (ignore-errors (car (nous--lines (nous--run "resolve" ref)))))

(defun nous--resolve (ref)
  "The absolute path REF names, or nil when it names nothing."
  (nth 1 (nous--resolved ref)))

(defun nous--id (ref)
  "The identity REF names, or nil when it names nothing."
  (nth 0 (nous--resolved ref)))

(defun nous--this-entity ()
  "The identity of the entity in this buffer, for the two commands that write it."
  (let ((file (or buffer-file-name (user-error "This buffer is not a file"))))
    (when (buffer-modified-p)
      (user-error "nous: save first — this moves or removes the file on disk"))
    (or (nous--id file) (user-error "nous: no entity here: %s" file))))

(defun nous--entities ()
  "Every entity, as (LABEL . IDENTITY) — recognition rather than recall (ADR-044)."
  (mapcar (lambda (f)
            ;; [domain] ? identity title metadata
            (let ((domain (nth 0 f)) (identity (nth 2 f)) (title (nth 3 f)))
              (cons (format "%-10s %s  %s" domain (or title "") identity) identity)))
          (nous--lines (nous--run "ls"))))

(defun nous-pick ()
  "Choose an entity and return its identity (REQ-117)."
  (let* ((choices (nous--entities))
         (chosen (completing-read "Entity: " choices nil t)))
    (cdr (assoc chosen choices))))

(defun nous--org-p ()
  (derived-mode-p 'org-mode))

;;;###autoload
(defun nous-open (identity)
  "Open the entity IDENTITY, prompting for it interactively."
  (interactive (list (nous-pick)))
  (find-file (or (nous--resolve identity)
                 (user-error "No such entity: %s" identity))))

(defun nous--domains ()
  "The domains this vault can reach."
  (mapcar #'car (nous--lines (nous--run "domains"))))

(defun nous--create (domain title)
  "Create TITLE in DOMAIN and return the identity `new' printed.
`nous new' opens the editor only when it is given no title (ADR-080), so
this is the form that answers with an identity instead of taking over the
terminal."
  (string-trim (apply #'nous--run
                      (append (list "new" domain title)
                              (when (nous--org-p) (list "--org"))))))

;;;###autoload
(defun nous-new (domain title)
  "Create a TITLE in DOMAIN and open it."
  (interactive (list (completing-read "Domain: " (nous--domains) nil t)
                     (read-string "Title: ")))
  (nous-open (nous--create domain title)))

;;;###autoload
(defun nous-rename (new)
  "Rename this buffer's entity to NEW, rewriting every reference (REQ-166, ADR-211).
`nous mv' moves the file and re-aims the references in both directions, so
what this command does is ask for a name and then open where the entity
went.  It refuses an unsaved buffer, because the file is about to move
underneath it."
  (interactive (list (read-string "New identity: " (nous--this-entity))))
  (let* ((old (current-buffer))
         (id (nous--this-entity)))
    (message "%s" (string-trim (nous--run "mv" id new)))
    ;; Where it went is asked for rather than read out of `mv's sentence: the
    ;; identity is the one thing we already know, and `resolve' turns it into the
    ;; file to visit.
    (let ((path (nous--resolve new)))
      (when path (find-file path))
      (when (and path (buffer-live-p old) (not (eq old (current-buffer))))
        (kill-buffer old)))))

;;;###autoload
(defun nous-delete ()
  "Remove this buffer's entity and the buffer with it (ADR-187, ADR-211).
`nous rm' refuses while another entity still references this one, and names
what does.  `--force' is what removes it anyway, and this command does not
offer it: a flag whose whole purpose is to leave broken references behind is
not a thing to reach by keystroke.  The question is `yes-or-no-p' rather
than a single key, because nothing undoes it."
  (interactive)
  (let ((id (nous--this-entity)))
    (unless (yes-or-no-p (format "Remove %s, permanently? " id))
      (user-error "nous: nothing was removed"))
    (message "%s" (string-trim (nous--run "rm" id)))
    (set-buffer-modified-p nil)
    (kill-buffer)))

(defun nous--pick-or-create ()
  "An entity, chosen or made: whichever, a reference to it can be written.
`nous-pick' requires a match because picking is recognition (ADR-044).
Here a word that matches nothing is a title nobody has written yet — the
thought arrives while you are writing the sentence that needs it — so it
is offered to `new', and what comes back is an identity, which is a
reference like any other (ADR-074).  The answer is never guessed at: the
domain is asked for, and C-g before that question leaves nothing behind."
  (let* ((choices (nous--entities))
         (chosen (completing-read "Entity, or a title to create: " choices nil nil)))
    (or (cdr (assoc chosen choices))
        (let ((made (nous--create
                     (completing-read (format "New \"%s\" in domain: " chosen)
                                      (nous--domains) nil t)
                     chosen)))
          (message "nous: created %s" made)
          made))))

;;;###autoload
(defun nous-insert-link (identity &optional type)
  "Insert a reference to IDENTITY, natively for this buffer's format (ADR-190).
IDENTITY may be one that does not exist yet: a title matching no entity is
created in a domain you are asked for, and the reference points at that.
With a prefix argument, name the relationship TYPE (REQ-071, ADR-014)."
  (interactive (list (nous--pick-or-create)
                     (when current-prefix-arg (read-string "Relationship: "))))
  ;; What a reference looks like is the core's, not an editor's (ADR-199). The
  ;; relative target, the name to show, the `#type' and the choice between Org and
  ;; Markdown are one question with one answer, and asking it here kept a fourth
  ;; copy of it in a file nobody has ever run.
  (insert (string-trim
           (apply #'nous--run
                  (append (list "link" (or buffer-file-name ".") identity "--print")
                          (when type (list "--as" type)))))))

(defun nous--target-at-point ()
  "The Nous reference target under point, or nil."
  (save-excursion
    (let ((line (thing-at-point 'line t))
          (col (- (point) (line-beginning-position))))
      (when line
        ;; both formats put the target between delimiters; take the one that
        ;; contains point, so a line with several links follows the right one
        (let ((case-fold-search nil) (found nil))
          (with-temp-buffer
            (insert line)
            (goto-char (point-min))
            (while (re-search-forward "\\(?:\\](\\|\\[\\[\\)\\([^])]+\\)" nil t)
              (when (and (not found) (<= (match-beginning 1) (+ col 1))
                         (>= (match-end 1) col))
                (setq found (match-string 1))))
            found))))))

;;;###autoload
(defun nous-follow ()
  "Follow the Nous reference under point (REQ-102: resolution is the core's)."
  (interactive)
  (let* ((target (or (nous--target-at-point) (user-error "No reference here")))
         (path (car (split-string target "#"))))
    (when (or (string-match-p "\\`[a-zA-Z][a-zA-Z0-9+.-]*:" path)
              (string-prefix-p "/" path))
      (user-error "Not a Nous reference: %s" path))
    ;; Resolution is the core's (REQ-102), and so is where the link was written
    ;; from: every call runs in the buffer's own directory, and from a draft that
    ;; directory stands for where the draft will live (REQ-303) — expanded here
    ;; it would name a file in /tmp that is nobody's entity.
    (nous-open path)))

(defun nous--row-path (fields)
  "The file the row FIELDS names, or nil.
Which field holds the identity differs by command — `doctor' answers
severity, identity, message; `related' answers identity first; a listing
answers REQ-104's five — so the row is not parsed.  Every field is offered
to `nous resolve', which is the core's answer to what a word names
(REQ-102), and the last one that names something wins: the fields after an
identity are prose, and the ones before it are a bracket or a severity."
  (car (last (delq nil (mapcar #'nous--resolve fields)))))

(defun nous--directed (arrow verb ref)
  "The rows VERB answers about REF, each labelled with ARROW.
`links' and `backlinks' both answer <relationship>\\t<identity>\\t<title>
to a pipe, so the two fit in one prompt once a row says which way it
points."
  (mapcar (lambda (f) (cons (concat arrow " " (string-join f "  ")) f))
          (nous--lines (nous--run verb ref))))

;;;###autoload
(defun nous-jump ()
  "Go to an entity this one points at, or one that points at it (ADR-186).
Both directions in one prompt, because from inside a file the question is
\"where does this connect\" rather than which command answers it."
  (interactive)
  (let* ((ref (or buffer-file-name (user-error "This buffer is not a file")))
         (rows (append (nous--directed "->" "links" ref)
                       (nous--directed "<-" "backlinks" ref))))
    (unless rows
      (user-error "nous: nothing here points anywhere, and nothing points here"))
    (find-file (or (nous--row-path (cdr (assoc (completing-read "Go to: " rows nil t) rows)))
                   (user-error "No entity on that row")))))

(defun nous-report-open ()
  "Open the entity this row names — `nous--row-path' is the rule (ADR-207)."
  (interactive)
  (let* ((line (or (thing-at-point 'line t) (user-error "No row here")))
         (path (nous--row-path (split-string (string-trim line) "\t" t))))
    (find-file (or path (user-error "No entity on this row")))))

(defvar nous-report-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "RET") #'nous-report-open)
    m)
  "Keys for `nous-report-mode'.")

(define-derived-mode nous-report-mode special-mode "nous"
  "What nous answered, one entity to a row.  RET opens the one under point.")

(defun nous--report (name &rest args)
  "Show the output of nous ARGS in a buffer called NAME."
  (let ((out (condition-case err (apply #'nous--run args)
               (user-error (cadr err)))))
    (with-current-buffer (get-buffer-create name)
      (let ((inhibit-read-only t))
        (erase-buffer) (insert out) (goto-char (point-min)) (nous-report-mode))
      (display-buffer (current-buffer)))))

;;;###autoload
(defun nous-ls ()
  "Everything the vault holds."
  (interactive)
  (nous--report "*nous ls*" "ls"))

;;;###autoload
(defun nous-show (identity)
  "IDENTITY whole: what its domain says it is, its text, and its references."
  (interactive (list (nous-pick)))
  (nous--report "*nous show*" "show" identity))

;;;###autoload
(defun nous-links (identity)
  "What IDENTITY refers to."
  (interactive (list (nous-pick)))
  (nous--report "*nous links*" "links" identity))

;;;###autoload
(defun nous-backlinks (identity)
  "What refers to IDENTITY."
  (interactive (list (nous-pick)))
  (nous--report "*nous backlinks*" "backlinks" identity))

;;;###autoload
(defun nous-related (identity)
  "What resembles IDENTITY, and why."
  (interactive (list (nous-pick)))
  (nous--report "*nous related*" "related" identity))

;;;###autoload
(defun nous-search (text &optional meaning)
  "Search for TEXT; with a prefix argument, by what it MEANS (REQ-087, ADR-296).
`--meaning' needs the model the core fetches for itself, and where there is
none the core refuses by name, which is the message shown here."
  (interactive (list (read-string "Search: ") current-prefix-arg))
  (apply #'nous--report "*nous search*" "find" "--body"
         (append (when meaning (list "--meaning")) (list text))))

;;;###autoload
(defun nous-doctor ()
  "What is broken, invalid or suspicious (REQ-109)."
  (interactive)
  (nous--report "*nous doctor*" "doctor"))

(defcustom nous-check-on-save t
  "Whether saving a file in `nous-mode' asks its domain what is wrong with it."
  :type 'boolean :group 'nous)

(defcustom nous-refuse-invalid-save t
  "Whether an `invalid' finding stops the save that found it (ADR-210).
`invalid' is the only severity that means a fault; the other four are
reported and never in the way, here as everywhere else."
  :type 'boolean :group 'nous)

(defvar-local nous--rows nil
  "The rows of the last check of this buffer, so that one ask serves both
the refusal and the marks flymake leaves behind.")

(defun nous--check-rows ()
  "What this buffer's domain says about *what is in the buffer*.
`nous check' asks about a file, and the file on disk is the last thing
saved — which is the wrong question when the answer decides whether to
save at all.  So a modified buffer is written beside its own file and that
is what gets asked about: in a dot-prefixed *directory*, which is not walked
(ADR-176), so it is invisible to `ls' and to `doctor', while sitting under
the same domain root means nobody has to be told whose it is (ADR-007).
A draft is under no domain root at all, and the core knows whose it is from
the note it left beside the draft (ADR-301), so nothing is passed here: the
NOUS_DRAFT_DOMAIN an editor is started with is the wrong answer in an Emacs
that is a server, which keeps the environment of whatever started it.

**The copy keeps the file's own name.**  It used to be a dot-*file* called
`.nous-check-<pid>-NOUS-1.md', and a domain that works out anything from the
name of the file it is given — which is most of them, since identity is
location — was being asked about an entity that does not exist.  For `jira'
that silently disabled the whole of ADR-223's save-time warning: no base
copy is kept for `.nous-check-91-NOUS-1', so `check' had nothing to compare
and said nothing, every time."
  (let ((file buffer-file-name))
    (when file
      (let* ((dir (and (or (buffer-modified-p) (not (file-exists-p file)))
                       (expand-file-name
                        (format ".nous-check-%d" (emacs-pid))
                        (file-name-directory file))))
             (tmp (and dir (expand-file-name (file-name-nondirectory file) dir))))
        (unwind-protect
            (let* ((args (list "check" (or tmp file)))
                   ;; A non-zero exit is what a fault *is*, and the findings are on
                   ;; stdout either way, so both outcomes are the same answer.
                   (out (condition-case err
                            (progn (when tmp
                                     (make-directory dir t)
                                     (write-region nil nil tmp nil 'silent))
                                   (apply #'nous--run args))
                          (user-error (cadr err)))))
              ;; The path is the label in every row, and it is the temporary one.
              (mapcar (lambda (f)
                        (if (and tmp (equal (nth 1 f) tmp))
                            (cons (car f) (cons file (cddr f)))
                          f))
                      (nous--lines out)))
          (when tmp
            (ignore-errors (delete-file tmp))
            (ignore-errors (delete-directory dir))))))))

(defun nous--recheck ()
  "Ask, remember, and show — one ask, however many things want the answer."
  (setq nous--rows (nous--check-rows))
  (if (bound-and-true-p flymake-mode)
      (flymake-start)
    (message "%s" (if nous--rows
                      (string-join (mapcar (lambda (f) (string-join f " ")) nous--rows) "\n")
                    "nous: nothing to say about this")))
  nous--rows)

;;;###autoload
(defun nous-check ()
  "What this file's own domain says about it, before `doctor' ever sees it (ADR-078)."
  (interactive)
  (unless buffer-file-name (user-error "This buffer is not a file"))
  (nous--recheck))

(defconst nous--flymake-types
  '(("invalid" . :error) ("suspicious" . :warning) ("stale" . :note)
    ("suboptimal" . :note) ("informational" . :note))
  "REQ-028's five severities in the three types this editor has (ADR-207).
`invalid' is the only error because it is the only fault, which is the
same reading ADR-192 made of VSCode's four.  A word not in this table is
shown as a note rather than dropped: the core added it, and an editor
that cannot rank it can still say it.")

(defun nous-flymake (report-fn &rest _)
  "Report what this buffer's domain says about it to REPORT-FN.
The findings stay in the buffer until a later check has something else to
say, which is what makes them outlive the keystroke that clears the echo
area (ADR-210).  The seam carries no line number with a finding, so every
one lands on the first line — the same place ADR-192 puts them in the
Problems panel."
  (let ((region (flymake-diag-region (current-buffer) 1)))
    (funcall report-fn
             (mapcar (lambda (f)
                       (flymake-make-diagnostic
                        (current-buffer) (car region) (cdr region)
                        (or (cdr (assoc (nth 0 f) nous--flymake-types)) :note)
                        (format "%s: %s" (nth 0 f)
                                (string-join (or (cddr f) (cdr f)) "\t"))))
                     (or nous--rows (nous--check-rows))))))

(defcustom nous-tell-domains-on-save t
  "Whether saving a file in `nous-mode' tells its domain that it was saved.
`nous saved' fires ADR-026's event and the core does nothing else with it
(REQ-205), so this is safe to leave on: a domain that has nothing to do
with a save answers nothing, and one that does — `jira' pushes what you
wrote — acts only where the vault has asked it to.  That is the domain's
setting to read and not this client's business to know about (REQ-102)."
  :type 'boolean :group 'nous)

(defun nous--after-save ()
  "Tell this file's domain that it was saved, and say what came back.
After rather than before, because a save that has not happened is not news
— which is the whole difference between this and `nous--before-save', where
the point is to decline while declining is still possible (ADR-210).

Nothing here can fail a save.  The file is already on disk, and a domain
that answers badly must not turn a written buffer into an error: what comes
back is a message, and so is a failure.

Two things worth knowing before turning a domain's own on-save action on.
The call is synchronous, so a vault that has asked the jira domain for
push-on-save waits for Jira at this point — which is the cost ADR-223
records and leaves switched off.  And a domain that rewrites the file will
leave this buffer holding the older text; Emacs notices that by itself and
asks before the next save, so nothing is lost quietly.

A draft is skipped.  It is not an entity yet — the core is still waiting to
be handed the file (ADR-076) — so there is no domain to tell."
  (when (and nous-tell-domains-on-save
             (buffer-file-name)
             (not (nous--draft-p)))
    (condition-case err
        (dolist (row (nous--lines (nous--run "saved" (buffer-file-name))))
          ;; The severity, then whatever the domain said, and this client
          ;; reads neither (REQ-102).
          (message "nous: %s" (string-join (cdr row) " ")))
      (user-error (message "nous: %s" (cadr err))))))

(defun nous--invalid (rows)
  "The ROWS that are faults, which is the ones that say `invalid' (REQ-028)."
  (seq-filter (lambda (f) (equal (nth 0 f) "invalid")) rows))

(defun nous--before-save ()
  "Ask this file's domain about the buffer, and refuse the save on a fault.
Before rather than after, because after is too late to decline: what is on
disk would already be the thing the domain calls invalid.  `C-x C-s' with
no change to fix nothing asks again and refuses again; \\[write-file] to
another name, or `nous-refuse-invalid-save' set to nil, is how a fault gets
onto disk deliberately.

A draft is the exception: there the core is already the thing that refuses,
and it offers the editor back (ADR-076).  Refusing the save as well would
take away the only way of handing the draft over — and of walking away from
it, which is an answer too."
  (when nous-check-on-save
    (let ((bad (nous--invalid (nous--recheck))))
      (when (and bad nous-refuse-invalid-save
                 (not (nous--draft-p)))
        (user-error "nous: not saved, %s"
                    (string-join (mapcar (lambda (f) (string-join (cddr f) " ")) bad)
                                 "; "))))))

(defun nous--json (text)
  "TEXT parsed as JSON, objects as alists keyed by symbol and arrays as lists.
The native parser where this Emacs was built with one, and json.el, which
every Emacs has, where it was not — an Emacs without libjansson has no
`json-parse-string' at all, and that is the one way for `show --format json'
to answer and this client to hear nothing."
  (if (fboundp 'json-parse-string)
      (json-parse-string text :object-type 'alist :array-type 'list)
    (let ((json-object-type 'alist) (json-array-type 'list))
      (json-read-from-string text))))

(defun nous--shown ()
  "What `show --format json' says of the file in this buffer, or nil.
One answer for an entity and for a draft alike (ADR-301): the domain, the
identity, and whether it is a draft, none of which is worked out here
(REQ-102). `jira/NOUS-1' begins with its domain and that is exactly the
shape a client is not allowed to recognise, and NOUS_DRAFT_DOMAIN is exactly
the variable it must not read — an Emacs that is a server keeps the one it
was started with for every draft after, which is how a jira ticket was
offered gtd's words."
  (let ((file (or (buffer-file-name) (user-error "nous: this buffer is no file"))))
    (ignore-errors (nous--json (nous--run "show" file "--format" "json")))))

(defun nous--draft-p ()
  "Whether this buffer holds a draft: the core says so, and nothing else does."
  (eq t (alist-get 'draft (nous--shown))))

(defun nous--this ()
  "The domain and the identity of the file in this buffer, as (DOMAIN . ID).
For a draft the identity is the entity it is a copy of, and empty for one
`new' has not created yet."
  (let* ((file (or (buffer-file-name) (user-error "nous: this buffer is no file")))
         (json (or (nous--shown)
                   ;; Asked again rather than reported as nothing: `nous--shown'
                   ;; swallows the failure, because a buffer visiting a file no
                   ;; domain owns is ordinary and not worth a message.  When
                   ;; something *is* wrong — a vault whose config names no
                   ;; domains, say (ADR-305) — the core has already written the
                   ;; sentence that ends it, and a client that throws it away
                   ;; leaves the person with a completion that has quietly
                   ;; stopped answering and no way to find out why (REQ-102).
                   (nous--json (nous--run "show" file "--format" "json")))))
    (cons (alist-get 'domain json) (alist-get 'id json))))

;;;###autoload
(defun nous-run ()
  "Run one of this file\'s own domain\'s operations on it (ADR-228).
The operations are whatever the domain declares — `nous ops\' answers with
them and with which of them are about one entity — so this command needs
extending for no domain, ever, and names none.  `jira\'s `attach\' is what
asked for it: the attachments live in the cache since ADR-225, and a path in
`nous show\' is not something an editor can open.

A verb the domain marked `entity\' is given this file.  One that did not is
about every entity there is, and gets nothing."
  (interactive)
  (let* ((this (nous--this))
         (rows (seq-filter (lambda (r) (equal (car r) (car this)))
                           (nous--lines (nous--run "ops"))))
         (verbs (mapcar (lambda (r) (cons (format "%s — %s" (nth 1 r) (nth 2 r)) r)) rows))
         (chosen (or (cdr (assoc (completing-read
                                  (format "%s operation: " (car this))
                                  (mapcar #'car verbs) nil t)
                                 verbs))
                     (user-error "nous: nothing chosen"))))
    (message "nous: %s"
             (string-trim
              (apply #'nous--run "run" (car this) (nth 1 chosen)
                     ;; The fourth field is the domain's claim that the verb is
                     ;; about one entity (ADR-217, ADR-228).
                     (if (equal (nth 3 chosen) "entity") (list (cdr this)) nil))))))

;;;###autoload
(defun nous-set (key value)
  "Set KEY of this buffer's entity to VALUE, or remove it when VALUE is empty (ADR-275).
The keys are what `nous schema' says this domain answers for, the words
offered are that key's own, and `nous set' hands the change to the domain,
which refuses what it will not hold — the domain validates and this client
decides nothing (REQ-102).  It is what a click does in the graphical clients,
for a hand that would rather not leave the keyboard.  The write is to the
file, so the buffer is reverted afterwards; a modified buffer is refused
first, because reverting one throws the edit away."
  (interactive
   (progn
     (when (buffer-modified-p)
       (user-error "nous: save first — set rewrites the file on disk"))
     (let* ((keys (nous--lines (nous--run "schema" (car (nous--this)))))
            ;; domain  key  type  required|optional  the words, comma-separated
            (key (completing-read "Key: " (mapcar (lambda (r) (nth 1 r)) keys) nil t))
            (row (seq-find (lambda (r) (equal (nth 1 r) key)) keys))
            (words (nous--words (cons key (cons (nth 2 row) (split-string (or (nth 4 row) "") ", " t))))))
       (list key (completing-read (format "%s (empty removes): " key) words)))))
  (message "%s" (string-trim
                 (apply #'nous--run "set" (cdr (nous--this)) key
                        (unless (string-empty-p value) (list value)))))
  (revert-buffer t t t))

;;;###autoload
(defun nous-settings ()
  "Every setting in force, and the file each came from (ADR-082)."
  (interactive)
  (nous--report "*nous settings*" "config"))

(defun nous--config-check ()
  "Say what the vault makes of the settings file after it is saved.
The settings file is not an entity, so `nous-mode' and its refusal are not
what watches it (ADR-210).  `config' answers with the settings it could read
and says nothing about the ones it could not, so the command that reports an
unparseable file is `doctor', where it is an observation and not a fault
(ADR-055): a vault with a broken settings file still works, with none of
them in force."
  (let ((out (condition-case err (nous--run "doctor") (user-error (cadr err)))))
    (dolist (row (nous--lines out))
      (when (member "config" row)
        (message "nous: %s" (string-join (cddr row) " "))))))

(defun nous--config-file (layer)
  "The file LAYER's settings are written to, as `config' reports it.
`nous config --format json' answers with the cascade and what is in force
(ADR-213, REQ-181); the client asks for a layer by the word a program reads
— \"vault\", \"global\", \"user\" — and never by matching the phrase a
person reads beside it."
  (let* ((json (nous--json (nous--run "config" "--format" "json")))
         (files (alist-get 'files json)))
    (or (cdr (assq 'file (seq-find (lambda (f) (equal (alist-get 'layer f) layer))
                                   files)))
        (user-error "nous: no %s settings file in this vault" layer))))

;;;###autoload
(defun nous-config (&optional user)
  "Open this vault's settings in a buffer; with a prefix argument, your own.
An ordinary buffer on the real file, not a draft in /tmp and not another
Emacs (ADR-213).  Where the file is, is the core's answer and not this
client's arithmetic (REQ-102): a layer that has no file yet is named all the
same, so this is also how the first one gets written.  Saving asks the vault
what it now makes of it, so a typo is reported rather than found later."
  (interactive "P")
  (find-file (nous--config-file (if user "user" "vault")))
  (add-hook 'after-save-hook #'nous--config-check nil t))

;;;###autoload
(defun nous-resurface ()
  "A sample of what you have not looked at lately (ADR-021)."
  (interactive)
  (nous--report "*nous resurface*" "resurface" "5"))

(defvar nous-prefix-map
  (let ((m (make-sparse-keymap)))
    (define-key m "n" #'nous-new)
    (define-key m "o" #'nous-open)
    (define-key m "l" #'nous-insert-link)
    (define-key m "f" #'nous-follow)
    (define-key m "j" #'nous-jump)
    ;; The two writes that act on an entity that exists.  `m' is the move; `k' is
    ;; the one that cannot be undone, on the letter Emacs already spells "kill".
    (define-key m "m" #'nous-rename)
    (define-key m "k" #'nous-delete)
    (define-key m "b" #'nous-backlinks)
    (define-key m "s" #'nous-search)
    (define-key m "d" #'nous-doctor)
    (define-key m "c" #'nous-check)
    (define-key m "r" #'nous-run)
    (define-key m "S" #'nous-show)
    (define-key m "L" #'nous-links)
    ;; `r' was this one's until ADR-228 gave it to `nous-run', and the second
    ;; `define-key' silently took it: two bindings on one letter in one sparse
    ;; keymap leave the first unreachable.  Upper case, as `S' and `L' are, for
    ;; the same reason -- the lower-case letter is spoken for.
    (define-key m "R" #'nous-related)
    (define-key m "e" #'nous-ls)
    (define-key m "u" #'nous-resurface)
    (define-key m "C" #'nous-config)
    (define-key m "g" #'nous-settings)
    ;; `key=value' is how the query language spells a key holding a value.
    (define-key m "=" #'nous-set)
    m)
  "The Nous commands, under `C-c n' in `nous-mode-map'.
It is a keymap rather than a binding apiece so that it can be had
somewhere a vault file is not the current buffer — a dired listing, a
report, the scratch buffer:

  (global-set-key (kbd \"C-c n\") nous-prefix-map)")

(defvar-local nous--schema nil
  "What `schema' says of this buffer's domain, as (KEY TYPE . WORDS), asked once.")

(defun nous--dates ()
  "Today, tomorrow and a week from now, as a `date' key is written.
What a date key holds is a day, `YYYY-MM-DD' and nothing else, and these
three are the days a person reaches for; any other is typed."
  (mapcar (lambda (days) (format-time-string "%Y-%m-%d" (time-add nil (* days 86400))))
          '(0 1 7)))

(defun nous--words (row)
  "The words to offer for schema ROW: the domain's own, or the days for a date."
  (or (cddr row) (and (equal (cadr row) "date") (nous--dates))))

(defun nous--schema ()
  "The keys this buffer's domain answers for and the words each allows (ADR-072).
An entity's domain is what `show' says, and so is a draft's (ADR-301).  Asked once per buffer, and a failure is
remembered as one, so that it is said once and not on every keystroke."
  (when (null nous--schema)
    (setq nous--schema
          ;; Said rather than swallowed: a completer that answers nothing
          ;; hands the line to whatever completer is next, and the person
          ;; sees words from another buffer with no way to tell why.
          (condition-case err
              (mapcar (lambda (r) (cons (nth 1 r) (cons (nth 2 r) (split-string (or (nth 4 r) "") ", " t))))
                      (nous--lines (nous--run "schema" (car (nous--this)))))
            (error (message "nous: no schema for this buffer: %s"
                            (error-message-string err))
                   'none))))
  (and (listp nous--schema) nous--schema))

(defun nous--keys-held ()
  "The keys this buffer already has a line for."
  (save-excursion
    (goto-char (point-min))
    (let (held)
      (while (re-search-forward "^\\(?:#\\+\\)?\\([A-Za-z_-]+\\):" nil t)
        (push (match-string-no-properties 1) held))
      held)))

(defun nous-capf ()
  "Complete a key's own words after `key:', or a key the file has not got.
A line beginning with a key the domain published offers that key's words,
which is what the page's editor does (ADR-072).  A comma is a list
(ADR-166), so the word being completed is what follows the last one.  A
key with no vocabulary offers nothing, except a date, which offers today,
tomorrow and a week from now.

A line holding nothing, or a bare word, offers the keys the domain
publishes that no line of the file holds yet, and picking one writes it
with its colon — which is ADR-282's rule that a key the entity has not got
is offered where it would go.  Not exclusive, so a word that is no key
falls through to whatever completer is next.

Nothing here knows which line is front matter: the keys are the domain's
and the words are the domain's, and that is all this reads (REQ-102)."
  (let ((end (point)))
    (save-excursion
      (beginning-of-line)
      (cond
       ((looking-at "\\(?:#\\+\\)?\\([A-Za-z_-]+\\):")
        (let ((words (nous--words (assoc (match-string-no-properties 1) (nous--schema))))
              (start (progn (goto-char end)
                            (skip-chars-backward "^:,")
                            (skip-chars-forward " ")
                            (point))))
          (when (and words (<= start end))
            (list start end words))))
       ((and (looking-at "\\(?:#\\+\\)?\\([A-Za-z_-]*\\)$")
             (<= (match-beginning 1) end (match-end 1)))
        (let* ((start (match-beginning 1))
               (held (nous--keys-held))
               (keys (seq-remove (lambda (k) (member k held))
                                 (mapcar #'car (nous--schema)))))
          (when keys
            (list start end keys
                  :exclusive 'no
                  :exit-function (lambda (_key status)
                                   (when (eq status 'finished) (insert ": ")))))))))))

(defcustom nous-view-in-normal-state t
  "Whether evil's normal state shows the entity rendered and insert shows its text.
The page has a view and an editor (ADR-278): the view hides the markup and
draws a reference as its word, and the editor shows every character that
will be saved.  In evil those are two states of one buffer, so normal state
is the view and insert state is the editor, switched on entry to each.  What
renders is the format's own mode — `markdown-mode' hiding its markup,
`org-mode' its link targets and emphasis markers — because a client learns
no format (REQ-102).  Nothing happens in a buffer where evil is not on."
  :type 'boolean :group 'nous)

(defvar org-link-descriptive)
(defvar org-hide-emphasis-markers)
(defvar markdown-hide-markup)
(defvar evil-state)

(defun nous--view (on)
  "Render this buffer the way its format's mode can when ON, else show its text.
Both modes hide markup through the buffer's invisibility spec, so that is
what is set, and the mode's own variable beside it so the mode agrees."
  (cond ((derived-mode-p 'org-mode)
         (if on (add-to-invisibility-spec '(org-link))
           (remove-from-invisibility-spec '(org-link)))
         (setq-local org-link-descriptive on
                     org-hide-emphasis-markers on))
        ((derived-mode-p 'markdown-mode)
         (if on (add-to-invisibility-spec 'markdown-markup)
           (remove-from-invisibility-spec 'markdown-markup))
         (setq-local markdown-hide-markup on)))
  (font-lock-flush))

(defun nous--follow-state ()
  "View in normal state, text in the states that edit."
  (when nous-view-in-normal-state
    (nous--view (not (memq evil-state '(insert replace))))))

(defvar nous-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "C-c n") nous-prefix-map)
    m)
  "Keys for `nous-mode'.")

;;;###autoload
(define-minor-mode nous-mode
  "Minor mode for editing files in a Nous vault."
  :lighter " nous" :keymap nous-mode-map
  (if nous-mode
      (progn
        (add-hook 'before-save-hook #'nous--before-save nil t)
        (add-hook 'after-save-hook #'nous--after-save nil t)
        (add-hook 'flymake-diagnostic-functions #'nous-flymake nil t)
        ;; `check' pays the vault walk (ADR-200), so it is asked when a save asks
        ;; it and not every half-second of idleness.  A finding therefore stands
        ;; until the next save has something else to say, which is the whole of
        ;; what makes it persistent.
        (setq-local flymake-no-changes-timeout nil)
        ;; The `t' a local hook keeps means "and then the global ones", and the
        ;; global one is the legacy backend, which warns in every vault buffer
        ;; that it has no idea what to do with the file. It has not.
        (setq-local flymake-diagnostic-functions (delq t flymake-diagnostic-functions))
        (flymake-mode 1)
        (add-hook 'completion-at-point-functions #'nous-capf nil t)
        (add-hook 'evil-normal-state-entry-hook #'nous--follow-state nil t)
        (add-hook 'evil-insert-state-entry-hook #'nous--follow-state nil t)
        (add-hook 'evil-replace-state-entry-hook #'nous--follow-state nil t)
        (when (bound-and-true-p evil-local-mode) (nous--follow-state)))
    (remove-hook 'before-save-hook #'nous--before-save t)
    (remove-hook 'after-save-hook #'nous--after-save t)
    (remove-hook 'flymake-diagnostic-functions #'nous-flymake t)
    (remove-hook 'completion-at-point-functions #'nous-capf t)
    (remove-hook 'evil-normal-state-entry-hook #'nous--follow-state t)
    (remove-hook 'evil-insert-state-entry-hook #'nous--follow-state t)
    (remove-hook 'evil-replace-state-entry-hook #'nous--follow-state t)
    (when (and nous-view-in-normal-state (bound-and-true-p evil-local-mode))
      (nous--view nil))
    (flymake-mode -1)))

(provide 'nous)
;;; nous.el ends here
