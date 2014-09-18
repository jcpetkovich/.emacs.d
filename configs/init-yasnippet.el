

(require-package 'yasnippet)
(require-package 'buster-snippets)
(require 'snippet-helpers)

;;; Use only my own snippets
(setq yas-snippet-dirs `(,(expand-file-name (concat user-emacs-directory "snippets"))))

(yas-global-mode 1)
(global-set-key (kbd "C-x y") 'yas/insert-snippet)

;;; Sometimes with certain more complex snippets, evil can choke
;;; trying to get back to normal-mode
(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'init-yasnippet)
