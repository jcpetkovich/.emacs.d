
(require-package 'ac-nrepl)
(require-package 'clojure-mode)
(require-package 'cider)

(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(provide 'setup-clojure)
