;; init-coffee.el - Setup emacs for editing python.

(req-package coffee-mode
  :config
  (progn
    (setq-default coffee-tab-width 2)))

(provide 'init-coffee)
