
(add-to-list 'auto-mode-alist '("\.mako$" . html-mode))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'insert html-mode-map
                       (kbd "M-<tab>") 'yas/expand)))

