
(require 'setup-package)
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

(defun setup-clojure-autocomplete ()
  (setq ac-auto-start nil)
  (add-to-list 'completion-at-point-functions 'auto-complete))
(add-hook 'nrepl-mode-hook #'setup-clojure-autocomplete)
(add-hook 'nrepl-interaction-mode-hook #'setup-clojure-autocomplete)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(provide 'setup-clojure)
