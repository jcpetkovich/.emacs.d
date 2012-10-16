
(add-to-list 'load-path "~/jc-public/site-lisp/swank-js/")

(require 'slime)
(require 'slime-js)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
