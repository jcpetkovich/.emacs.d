(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

(defalias 'perl-mode 'cperl-mode)

(add-hook 'cperl-mode-hook
          (lambda () (flymake-mode 1)))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'visual cperl-mode-map
       (kbd "<tab>") 'indent-for-tab-command)
     (evil-declare-key 'normal cperl-mode-map
       (kbd "C-c d") 'cperl-perldoc)))

(provide 'setup-perl)
