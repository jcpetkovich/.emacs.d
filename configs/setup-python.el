
(require 'setup-flymake)
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(require 'pymacs)

(provide 'setup-python)
