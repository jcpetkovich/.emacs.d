
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-cursor")
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-easy")
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(provide 'setup-python)
