(require-package 'whitespace-cleanup-mode)

;;; Be nice to git, whitespace where none is necessary or useful is
;;; impolite
(global-whitespace-cleanup-mode)

;;; Don't remove extraneous space at the BOF and EOF please.
(provide 'setup-whitespace-mode)
