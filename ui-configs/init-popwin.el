;; setup-popwin.el - configure helm and related packages

;; (require-package 'popwin)
;; (require 'popwin)
;; (popwin-mode 1)

(setq popwin:special-display-config '((help-mode :height 40)
                                      (completion-list-mode :height 30 :noselect t)
                                      (compilation-mode :height 30 :noselect t)))

(defun clear-popwin-timers ()
  "Can't think of a better solution right now"
  (interactive)
  (-each timer-list
    (lambda (timer)
      (if (s-match "popwin" (symbol-name (aref timer 5)))
          (cancel-timer timer)))))

(provide 'init-popwin)
