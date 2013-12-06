

(require-package 'yasnippet)
(require-package 'buster-snippets)

(yas-global-mode 1)
(global-set-key (kbd "C-`") 'yas/insert-snippet)

;;; Sometimes with certain more complex snippets, evil can choke
;;; trying to get back to normal-mode
(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'setup-yasnippet)
