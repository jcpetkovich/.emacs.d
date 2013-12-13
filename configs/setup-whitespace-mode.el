
(require-package 'whitespace-cleanup-mode)

;;; Be nice to git, whitespace where none is necessary or useful is
;;; impolite
(global-whitespace-cleanup-mode)

(set-default 'whitespace-cleanup-mode-only-if-initially-clean nil)

;;; Don't remove extraneous space at the BOF and EOF please.
(setq whitespace-style
      (remove-if (lambda (q) (eq q 'empty)) whitespace-style))

(provide 'setup-whitespace-mode)
