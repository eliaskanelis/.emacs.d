#!/bin/sh -e
#
# Loads early-init.el + init.el in batch mode and processes the elpaca queue,
# i.e. exactly what a fresh install does. Non-zero exit means the config is broken.

# NOTE: this fails the build if ANY package fails to install -- deliberately,
# since a half-installed image is worse than no image. It does mean every forge
# a package is hosted on becomes a build dependency; git-timemachine (codeberg)
# is currently the only non-GitHub one.
#
# A permanently blocked order makes elpaca-wait spin forever, which would hang
# `docker build` rather than fail it.  Cap it where timeout(1) is available.
if command -v timeout >/dev/null 2>&1; then TIMEOUT="timeout 1800"; else TIMEOUT=""; fi

echo "Attempting startup..."
${TIMEOUT} ${EMACS:=emacs} -nw --batch \
                --eval '(progn
                        (defvar url-show-status)
                        ;; debug-on-error is load-bearing, not just for
                        ;; debugging: elpaca wraps every use-package :config
                        ;; body in condition-case-unless-debug, which only
                        ;; re-signals when it is non-nil.  Without it a broken
                        ;; :config degrades to a warning and this script exits 0.
                        (setq backtrace-on-error-noninteractive t)
                        (let ((debug-on-error t)
                              (url-show-status nil)
                              ;; Batch sets after-init-time before we get to
                              ;; load init.el.  Elpaca uses it to decide whether
                              ;; an order came from the init file, which the
                              ;; lock file writer filters on -- so unset it to
                              ;; reproduce a real startup.
                              (after-init-time nil)
                              (user-emacs-directory default-directory)
                              (user-init-file (expand-file-name "init.el"))
                              (load-path (delq default-directory load-path)))
                           (setq package-check-signature nil)
                           (load-file (expand-file-name "early-init.el"))
                           (load-file user-init-file)
                           (require (quote elpaca))
                           (elpaca-process-queues)
                           (elpaca-wait)
                           ;; elpaca records a clone/build failure as a status
                           ;; on the order and keeps going; neither
                           ;; elpaca-process-queues nor elpaca-wait signals.
                           ;; Anything not "finished" means a half-installed
                           ;; config.  In practice elpaca-wait only returns
                           ;; once every order is finished or failed, so a
                           ;; permanently blocked one is caught by the timeout
                           ;; above, not by this scan.
                           (let ((bad (delq nil
                                      (mapcar (lambda (c)
                                                (and (not (eq (elpaca<-status (cdr c)) (quote finished)))
                                                     (car c)))
                                              (elpaca--queued)))))
                             (when bad
                               (message "Packages failed to install: %S" bad)
                               (kill-emacs 1)))
                           ;; Only now: the hook writes the lock file, and a
                           ;; package that cloned but failed to build would
                           ;; otherwise be pinned in its broken state.
                           (run-hooks (quote elpaca-after-init-hook))))'
echo "Startup successful"
