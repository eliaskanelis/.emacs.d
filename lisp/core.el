;;; core.el --- Core utilities -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------

(defun log (fmt &rest args)
  "Append a formatted message to /dev/stdout or a file."
  (with-temp-buffer
    (insert (format-time-string "[%F %T] "))
    (insert (apply #'format fmt args))
    (insert "\n")
	(write-region (point-min) (point-max)
				"/dev/stdout"
				'append   ;; append
				0)))      ;; suppress "Added to …" message

;; ---------------------------------------------------------------------------

(defun is-windows-p () (eq system-type 'windows-nt))
(defun is-linux-p ()   (eq system-type 'gnu/linux))
(defun is-mac-p ()     (eq system-type 'darwin))

(defun is-gui-p () (display-graphic-p))
(defun is-cli-p () (not (display-graphic-p)))

(defun is-font-available-p (name)
  "Return t if font NAME exists on the system."
  (not (null (find-font (font-spec :name name)))))

;; ---------------------------------------------------------------------------
(provide 'core)
;;; core.el ends here