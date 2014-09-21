(require-package 'company)
(require-package 'helm-company)
(require 'company)
(require 'init-evil)
(require 'init-auto-complete)

(define-key company-active-map (kbd "C-h") 'help-command)
(define-key company-active-map (kbd "C-w") 'kill-region-or-backward-word)
(define-key company-active-map (kbd "C-l") 'company-show-location)
(define-key company-active-map (kbd "M-1") nil)
(define-key company-active-map (kbd "M-2") nil)
(add-hook 'after-init-hook 'global-company-mode)

(setq-default company-idle-delay 0.3)

(defun use-auto-complete-instead ()
  (company-mode -1)
  (auto-complete-mode 1))

(add-hook 'ess-mode-hook 'use-auto-complete-instead)

(global-set-key (kbd "C-:") 'helm-company)

(provide 'init-company)
