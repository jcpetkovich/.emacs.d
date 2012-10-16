
(add-to-list 'load-path "~/jc-public/site-lisp/evil-surround/")

(eval-after-load "evil"
  '(progn
     (require 'surround)
     (global-surround-mode 1)))
