;; ============================================================= 
;; Viper keybindings
;; ============================================================= 

;; (define-key viper-insert-global-user-map (kbd "C-a") 'shrink-whitespaces)
;; (define-key viper-vi-global-user-map (kbd "C-a") 'shrink-whitespaces)
;; (define-key viper-insert-global-user-map (kbd "C-r") 'isearch-backward)
;; (define-key viper-vi-global-user-map (kbd "C-r") 'isearch-backward)
;; (define-key viper-insert-global-user-map (kbd "C-n") 'number-to-register)
;; (define-key viper-vi-global-user-map (kbd "C-n") 'number-to-register)
;; (define-key viper-insert-global-user-map (kbd "C-v") 'insert-register)
;; (define-key viper-vi-global-user-map (kbd "C-v") 'insert-register)
;; (define-key viper-insert-global-user-map (kbd "C-l") 'copy-to-register)
;; (define-key viper-vi-global-user-map (kbd "C-l") 'copy-to-register)
;; (define-key viper-insert-global-user-map (kbd "C-+") 'increment-register)
;; (define-key viper-vi-global-user-map (kbd "C-+") 'increment-register)
;; (define-key viper-insert-global-user-map (kbd "<f6>") 'browse-kill-ring)
;; (define-key viper-vi-global-user-map (kbd "<f6>") 'browse-kill-ring)
;; (define-key viper-insert-global-user-map (kbd "C-h") 'mark-paragraph)
;; (define-key viper-vi-global-user-map (kbd "C-h") 'mark-paragraph)
;; (define-key viper-insert-global-user-map (kbd "C-u") 'universal-argument)
;; (define-key viper-vi-global-user-map (kbd "C-u") 'viper-scroll-down)
;; (define-key viper-vi-global-user-map (kbd "C-d") 'viper-scroll-up)

;; (define-key viper-insert-global-user-map (kbd "C-M-<backspace>") 'paredit-backward-delete)
;; (define-key viper-vi-global-user-map (kbd "C-M-<backspace>") 'paredit-backward-delete)

;; (define-key minibuffer-local-map (kbd "M-s") 'other-window) ; was nest-matching-history-element


;; (add-hook 'slime-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))

;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (vimpulse-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))



(global-set-key (kbd "C-w") 'backward-kill-word)

;; (mapcar (lambda (state)
;;           (evil-declare-key state org-mode-map
;;                             (kbd "M-l") 'org-metaright
;;                             (kbd "M-h") 'org-metaleft
;;                             (kbd "M-k") 'org-metaup
;;                             (kbd "M-j") 'org-metadown
;;                             (kbd "M-L") 'org-shiftmetaright
;;                             (kbd "M-H") 'org-shiftmetaleft
;;                             (kbd "M-K") 'org-shiftmetaup
;;                             (kbd "M-J") 'org-shiftmetadown))
;;         '(normal insert))


