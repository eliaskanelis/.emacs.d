;; We use elpaca
(setq package-enable-at-startup nil)

;; Debugging
(setq debug-on-error t)
(setq debug-on-warning t)
(setq debug-on-load t)
(setq debug-ignored-errors nil)
(setq debug-on-signal t)           ;; Debug on all signals
(setq warning-minimum-level :debug) ;; Show all warnings, even debug level
(setq inhibit-message nil)  ;; Show all messages