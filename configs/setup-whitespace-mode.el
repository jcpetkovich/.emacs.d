(require-package 'whitespace-cleanup-mode)

(require 'whitespace)
(setq whitespace-style (remove 'indentation whitespace-style))

;;; Be nice to git, whitespace where none is necessary or useful is
;;; impolite
(global-whitespace-cleanup-mode)

(add-hook 'makefile-mode-hook (lambda () (whitespace-cleanup-mode -1)))

;;; Don't remove extraneous space at the BOF and EOF please.
(provide 'setup-whitespace-mode)
