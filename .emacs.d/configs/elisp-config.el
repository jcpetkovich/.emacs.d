
;;; Elisp paredit fix
;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))

;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (define-key lisp-mode-map (kbd "backspace") 'paredit-backward-delete)))

;;; Lisp paredit fix
;; (add-hook 'lisp-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))


;; (add-hook 'lisp-mode-hook
;;           (lambda ()
;;             (define-key lisp-mode-map (kbd "backspace") 'paredit-backward-delete)))

