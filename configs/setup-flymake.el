
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-cursor")
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-easy")

(eval-after-load "flymake"
  '(require 'flymake-cursor))

(provide 'setup-flymake)
