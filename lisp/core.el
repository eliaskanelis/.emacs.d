;;; core.el --- Core utilities -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------

(defun vb/log (fmt &rest args)
  "Write FMT formatted with ARGS, plus a timestamp, to stderr.
Deliberately bypasses `message' so these lines stay out of *Messages*.
Writing to \"/dev/stdout\" would signal `file-error' on Windows, which this
configuration supports."
  (princ (concat (format-time-string "[%F %T] ")
                 (apply #'format fmt args)
                 "\n")
         #'external-debugging-output))

;; ---------------------------------------------------------------------------

(defun is-windows-p ()
  "Return non-nil on Microsoft Windows."
  (eq system-type 'windows-nt))
(defun is-linux-p ()
  "Return non-nil on GNU/Linux."
  (eq system-type 'gnu/linux))
(defun is-mac-p ()
  "Return non-nil on macOS."
  (eq system-type 'darwin))

(defun is-gui-p ()
  "Return non-nil on a graphical display."
  (display-graphic-p))
(defun is-cli-p ()
  "Return non-nil on a terminal display."
  (not (display-graphic-p)))

(defun is-font-available-p (name)
  "Return t if font NAME exists on the system."
  (not (null (find-font (font-spec :name name)))))

;; ---------------------------------------------------------------------------
(provide 'core)
;;; core.el ends here
