
(require-package 'clojure-mode)
(require-package 'cider)
(require-package 'ac-cider)
(require-package 'company)

(require 'setup-evil)

(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)

(provide 'setup-clojure)
