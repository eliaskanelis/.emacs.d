;;; voidbuffer.el --- Voidbuffer utilities -*- lexical-binding: t; -*-

;;------------------------------------------------------------------------------
;; Log require

;; (defun log-require (orig-fun &rest args)
;;   (let ((feature (car args)))
;;     (log "[LOAD] Loading: %s" feature)
;;     (apply orig-fun args)))

;; (advice-add 'require :around #'log-require)

;; -----------------------------------------------------------------------------

;; (require 'use-package)
;; (require 'core)

;; (defun my/use-package-log (name keyword _args _rest _state)
;;   (log "[use-package] %s - handling %s" name keyword))

;; ;; Add advice for *all* use-package keywords
;; (dolist (kw '(:init :config :hook :bind :after :commands
;;                     :custom :custom-face :load-path :demand
;;                     :defer :magic :magic-fallback :mode))
;;   (advice-add (intern (format "use-package-handler/%s" kw))
;;               :before
;;               (lambda (&rest args)
;;                 (apply #'my/use-package-log args))))

;; -----------------------------------------------------------------------------
(provide 'voidbuffer)
;;; voidbuffer.el ends here