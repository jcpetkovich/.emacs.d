(when (file-exists-p (expand-file-name "~/src/perl/Emacs-PDE"))
  (add-to-list 'load-path "~/src/perl/Emacs-PDE/lisp"))

(add-hook 'cperl-mode-hook (lambda ()
                                (message "im disabling abbrev mode for pde")
                                (abbrev-mode -1)))

(load "pde-load")

(add-hook 'cperl-mode-hook
          (lambda ()
            (vimpulse-local-set-key 'visual-state (kbd "<tab>") 'indent-for-tab-command)))

;; (add-hook 'cperl-mode-hook
;;           (lambda ()
;;             (define-key cperl-mode-map (kbd "\M-;") ())))

;; (add-to-list 'load-path "~/src/perl/sepia")
;; (setq sepia-perl5lib (list (expand-file-name "~/src/perl/sepia/lib")))
;; (defalias 'perl-mode 'sepia-mode)
;; (require 'sepia)
