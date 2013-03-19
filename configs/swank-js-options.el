
(add-to-list 'load-path "~/jc-public/site-lisp/swank-js/")

(require 'slime)
(require 'slime-js)

(set-default 'slime-js-swank-command "swank-js")
(set-default 'slime-js-swank-args '())

(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(defun slime-js-run-swank ()
  "Runs the swank side of the equation."
  (interactive)
  (apply #'make-comint "swank-js" slime-js-swank-command nil slime-js-swank-args))

(defun slime-js-jack-in-node ()
  "Start a swank-js server and connect to it, opening a repl."
  (interactive)
  (slime-js-run-swank)
  (sleep-for 1)
  (setq slime-protocol-version 'ignore)
  (slime-connect "localhost" 4005))

