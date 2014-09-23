
(require 'init-evil)
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/evil-surround/")))

(require 'surround)
(global-surround-mode 1)

(provide 'init-evil-surround)
