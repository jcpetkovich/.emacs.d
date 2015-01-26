;; init-clojure.el - Setup emacs for editing clojure.

(req-package clojure-mode
  :commands clojure-mode)

(req-package cider
  :require (clojure-mode evil evil-leader)
  :config
  (progn
    (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
    (add-to-list 'evil-emacs-state-modes 'cider-docview-mode)
    (add-hook 'clojure-mode 'cider-turn-on-eldoc-mode)
    (setq-default cider-lein-parameters "trampoline repl :headless")

    (evil-leader/set-key-for-mode 'clojure-mode
      "mj" 'cider-jack-in
      "meb" 'cider-eval-buffer
      "mer" 'cider-eval-region
      "mes" 'cider-eval-last-sexp
      "mk"  'cider-load-buffer
      "mz"  'cider-switch-to-repl-buffer
      "mdd" 'cider-doc
      "mdg" 'cider-grimoire
      "mdj" 'cider-javadoc
      "mgv" 'cider-jump-to-var
      "mgr" 'cider-jump-to-resource
      "mge" 'cider-jump-to-compilation-error
      "mgs" 'cider-jump
      "mtt" 'cider-test-run-tests)

    (--each '(normal insert)
      (evil-declare-key it cider-repl-mode-map
        (kbd "M-r") 'cider-repl-previous-matching-input))))

(provide 'init-clojure)
