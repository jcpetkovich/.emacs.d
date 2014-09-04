(require-package 'company)
(require 'company)
(require 'setup-evil)

(define-key company-active-map (kbd "C-h") 'help-command)
(define-key company-active-map (kbd "C-w") 'backward-kill-word)
(define-key company-active-map (kbd "C-l") 'company-show-location)
(define-key company-active-map (kbd "M-1") nil)
(define-key company-active-map (kbd "M-2") nil)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'setup-company)
