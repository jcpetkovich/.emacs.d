(when (file-exists-p (expand-file-name "~/src/perl/Emacs-PDE"))
  (add-to-list 'load-path "~/src/perl/Emacs-PDE/lisp"))

(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

(add-hook 'cperl-mode-hook (lambda ()
                                (message "im disabling abbrev mode for pde")
                                (abbrev-mode -1)))

(load "pde-load")

(setq pde-perl-version "5.12.4")

;; (defalias 'perl-mode 'cperl-mode)

(add-hook 'cperl-mode-hook
          (lambda () (flymake-mode 1)))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'visual cperl-mode-map
                       (kbd "<tab>") 'indent-for-tab-command)
     (evil-declare-key 'normal cperl-mode-map
                       (kbd "C-c d") 'cperl-perldoc)))
