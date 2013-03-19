
(add-to-list 'load-path "~/.emacs.d/site-lisp/evil-surround/")

(eval-after-load "evil"
  '(progn
     (require 'surround)
     (global-surround-mode 1)))

(provide 'setup-evil-surround)
