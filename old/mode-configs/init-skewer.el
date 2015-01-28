;; init-skewer.el - Setup skewer mode.

;; Bookmarklet to load skewer:
;;
;; javascript:(function(){var d=document ;var s=d.createElement('script');s.src='http://localhost:8023/skewer';d.body.appendChild(s);})()
;;

(req-package skewer-mode
  :require js2-mode
  :config
  (progn
    (defun skewer-start ()
      (interactive)
      (let ((httpd-port 8023))
        (httpd-start)
        (message "Ready to skewer the browser. Now jack in with the bookmarklet.")))

    (defun skewer-demo ()
      (interactive)
      (let ((httpd-port 8024))
        (run-skewer)
        (skewer-repl)))

    (require 'skewer-mode)
    (require 'skewer-repl)
    (require 'skewer-html)
    (require 'skewer-css)))

(provide 'init-skewer)
