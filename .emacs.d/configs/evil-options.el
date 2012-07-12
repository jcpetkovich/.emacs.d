;; ============================================================= 
;; Viper keybindings
;; ============================================================= 


;; (define-key viper-insert-global-user-map (kbd "C-u") 'universal-argument)


;; (define-key minibuffer-local-map (kbd "M-s") 'other-window) ; was nest-matching-history-element


;; (add-hook 'slime-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))

;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (vimpulse-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))



(global-set-key (kbd "C-w") 'backward-kill-word)

(eval-after-load "evil"
  '(progn
     (define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)

     (mapcar (lambda (state)
               (evil-declare-key state global-map
                                 (kbd "C-a") 'shrink-whitespaces
                                 (kbd "C-n") 'number-to-register
                                 (kbd "C-l") 'copy-to-register
                                 (kbd "C-+") 'increment-register
                                 (kbd "<f6>") 'browse-kill-ring
                                 (kbd "C-M-<backspace>") 'paredit-backward-delete))
             '(normal insert))))




