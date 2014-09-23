
(require-package 'clojure-mode)
(require-package 'cider)

(require 'init-evil)

(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)

(--each '(normal insert)
  (evil-declare-key it cider-repl-mode-map
    (kbd "M-r") 'cider-repl-previous-matching-input))

(provide 'init-clojure)
