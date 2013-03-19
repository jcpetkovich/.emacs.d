

(add-to-list 'load-path "~/.emacs.d/site-lisp/expand-region")

(autoload 'er/expand-region "expand-region")

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'setup-expand-region)
