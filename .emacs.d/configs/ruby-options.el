;;; Fix paredit for ruby:
;; (add-hook 'ruby-mode-hook 'paredit-mode)
;; (add-hook 'ruby-mode-hook
;;           (lambda () 
;;             (viper-add-local-keys 'insert-state '(("{" . paredit-open-curly)
;;                                                   ("}" . paredit-close-curly)))))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))


