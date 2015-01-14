;; init-clojure.el - Setup emacs for editing clojure.

(req-package clojure-mode
  :commands clojure-mode)

(req-package cider
  :require (clojure-mode evil)
  :config
  (progn
    (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
    (add-to-list 'evil-emacs-state-modes 'cider-docview-mode)
    (add-hook 'clojure-mode 'cider-turn-on-eldoc-mode)
    (setq-default cider-lein-parameters "trampoline repl :headless")

    (--each '(normal insert)
      (evil-declare-key it cider-repl-mode-map
        (kbd "M-r") 'cider-repl-previous-matching-input))))

(provide 'init-clojure)
