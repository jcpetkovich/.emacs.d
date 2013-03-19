

(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/buster-snippets")

(require 'yasnippet)

(yas-global-mode 1)
(global-set-key (kbd "C-`") 'yas/insert-snippet)

(require 'buster-snippets)

(provide 'setup-yasnippet)
