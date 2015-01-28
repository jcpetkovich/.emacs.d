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
      (kbd "C-c d") 'cperl-perldoc)

    (setq-default
     cperl-auto-newline nil
     cperl-auto-newline-after-colon nil
     cperl-autoindent-on-semi t
     cperl-continued-statement-offset 0
     cperl-highlight-variables-indiscriminately t)))

(provide 'init-perl)
