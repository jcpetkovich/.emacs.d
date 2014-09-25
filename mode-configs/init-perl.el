;; init-perl.el - Setup emacs for editing perl.

(req-package cperl-mode
  :commands (cperl-mode perl-mode)
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
    (defalias 'perl-mode 'cperl-mode))

  :config
  (progn
    (evil-declare-key 'visual cperl-mode-map
      (kbd "<tab>") 'indent-for-tab-command)
    (evil-declare-key 'normal cperl-mode-map
      (kbd "C-c d") 'cperl-perldoc)))

(provide 'init-perl)
