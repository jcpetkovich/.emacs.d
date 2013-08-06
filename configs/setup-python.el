
(require 'setup-flymake)
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(require 'pymacs nil :noerror)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(provide 'setup-python)
