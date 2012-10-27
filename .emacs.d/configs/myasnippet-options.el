

(add-to-list 'load-path "~/jc-public/site-lisp/yasnippet")
(add-to-list 'load-path "~/jc-public/site-lisp/buster-snippets.el")
(require 'yasnippet)

(yas-global-mode 1)
(global-set-key (kbd "C-`") 'yas/insert-snippet)

(require 'buster-snippets)
