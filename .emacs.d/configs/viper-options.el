;; ============================================================= 
;; Setup Viper
;; ============================================================= 
(setq viper-mode t)                ; enable Viper at load time
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(require 'viper)                   ; load Viper
(setq vimpulse-experimental t)     ; load bleeding edge code (see 6. installation instruction)
(require 'vimpulse)                ; load Vimpulse
(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)


;; ============================================================= 
;; Viper keybindings
;; ============================================================= 
(define-key viper-insert-global-user-map (kbd "C-a") 'shrink-whitespaces)
(define-key viper-vi-global-user-map (kbd "C-a") 'shrink-whitespaces)
(define-key viper-insert-global-user-map (kbd "C-r") 'isearch-backward)
(define-key viper-vi-global-user-map (kbd "C-r") 'isearch-backward)
(define-key viper-insert-global-user-map (kbd "C-n") 'number-to-register)
(define-key viper-vi-global-user-map (kbd "C-n") 'number-to-register)
(define-key viper-insert-global-user-map (kbd "C-v") 'insert-register)
(define-key viper-vi-global-user-map (kbd "C-v") 'insert-register)
(define-key viper-insert-global-user-map (kbd "C-l") 'copy-to-register)
(define-key viper-vi-global-user-map (kbd "C-l") 'copy-to-register)
(define-key viper-insert-global-user-map (kbd "C-+") 'increment-register)
(define-key viper-vi-global-user-map (kbd "C-+") 'increment-register)
(define-key viper-insert-global-user-map (kbd "<f6>") 'browse-kill-ring)
(define-key viper-vi-global-user-map (kbd "<f6>") 'browse-kill-ring)
(define-key viper-insert-global-user-map (kbd "C-h") 'mark-paragraph)
(define-key viper-vi-global-user-map (kbd "C-h") 'mark-paragraph)
(define-key viper-insert-global-user-map (kbd "C-u") 'universal-argument)
(define-key viper-vi-global-user-map (kbd "C-u") 'viper-scroll-down)

(define-key viper-insert-global-user-map (kbd "C-M-<backspace>") 'paredit-backward-delete)
(define-key viper-vi-global-user-map (kbd "C-M-<backspace>") 'paredit-backward-delete)

(define-key minibuffer-local-map (kbd "M-s") 'other-window) ; was nest-matching-history-element

;;; fix viper mode delete key for paredit
;; (add-hook 'slime-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))

;; (add-hook 'slime-repl-mode-hook
;;           (lambda ()
;;             (viper-add-local-keys 'insert-state '(([(backspace)] . paredit-backward-delete)))))


;; (eval-after-load 'paredit
;;   '(progn
;;      (require 'paredit-viper-compat)
;;      (paredit-viper-compat)))

