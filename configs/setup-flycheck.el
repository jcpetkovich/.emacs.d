
;;; Code:
(require-package 'flycheck)
(require 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(setq-default flycheck-checkers
              (-remove (lambda (elem)
                         (-contains? '(emacs-lisp emacs-lisp-checkdoc) elem))
                       flycheck-checkers))

(provide 'setup-flycheck)
;;; setup-flycheck.el ends here
