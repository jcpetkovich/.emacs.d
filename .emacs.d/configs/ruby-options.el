;;; Fix paredit for ruby:
;; (add-hook 'ruby-mode-hook 'paredit-mode)
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(("{" . paredit-open-curly)
;;                                                   ("}" . paredit-close-curly)))))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))



;; MuMaMo-Mode for rhtml files
;; (require 'mumamo-fun)
;; (setq mumamo-chunk-coloring 'submode-colored)
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;; Rinari
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
;; (require 'rinari)

;; (setq
;;  nxhtml-global-minor-mode t
;;  mumamo-chunk-coloring 'submode-colored
;;  nxhtml-skip-welcome t
;;  indent-region-mode t
;;  rng-nxml-auto-validate-flag nil
;;  nxml-degraded t)
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

;; (setq load-path (cons "~/.emacs.d/rails" load-path))
;; (require 'rails)

(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))
