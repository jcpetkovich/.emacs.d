
(require 'setup-flymake)
(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(require 'pymacs nil :noerror)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
          (lambda ()
            (eval-after-load "evil"
              '(progn (dolist (mode '(normal insert))
                        (evil-declare-key mode jedi-mode-map
                          (kbd "M-.") 'jedi:goto-definition
                          (kbd "M-,") 'jedi:goto-definition-pop-marker))))))

(provide 'setup-python)
