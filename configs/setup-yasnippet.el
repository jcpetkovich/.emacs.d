

(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/buster-snippets")

(require 'yasnippet)

(yas-global-mode 1)
(global-set-key (kbd "C-`") 'yas/insert-snippet)

(require 'buster-snippets)

;;; Sometimes with certain more complex snippets, evil can choke
;;; trying to get back to normal-mode
(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'setup-yasnippet)
