
(require-package 'jedi)
(require-package 'ein)
(require-package 'flycheck)

(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
	  (lambda () 
	    (--each '(normal insert)
		    (evil-declare-key it jedi-mode-map
				      (kbd "M-.") 'jedi:goto-definition
				      (kbd "M-,") 'jedi:goto-definition-pop-marker))))

(provide 'setup-python)
