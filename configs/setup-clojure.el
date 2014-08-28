
(require-package 'clojure-mode)
(require-package 'cider)

(require 'setup-evil)

(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)

(provide 'setup-clojure)
