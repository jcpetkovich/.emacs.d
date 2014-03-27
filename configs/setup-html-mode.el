(require 'setup-evil)

(add-to-list 'auto-mode-alist '("\.mako$" . html-mode))

(evil-declare-key 'insert html-mode-map
  (kbd "M-<tab>") 'yas/expand)


(provide 'setup-html-mode)
