
;;; Code:
(require-package 'flycheck)
(require 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(setq flycheck-mode-line-lighter " FC")

(setq-default flycheck-checkers
              (-remove (lambda (elem)
                         (-contains? '(emacs-lisp emacs-lisp-checkdoc) elem))
                       flycheck-checkers))

(provide 'init-flycheck)
;;; setup-flycheck.el ends here
