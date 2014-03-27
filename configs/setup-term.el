
(require 'setup-evil)

(add-to-list 'evil-emacs-state-modes 'term-mode)

(add-hook 'term-mode-hook (lambda () (yas-minor-mode -1)))

(provide 'setup-term)
