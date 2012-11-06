;; =============================================================
;; Evil keybindings
;; =============================================================

(global-set-key (kbd "C-w") 'backward-kill-word)

(eval-after-load "evil"
  '(progn
     (define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)

     (mapcar (lambda (state)
               (evil-declare-key state global-map
                                 (kbd "C-a") 'shrink-whitespaces
                                 (kbd "C-n") 'evil-next-line
                                 (kbd "C-p") 'evil-previous-line
                                 (kbd "C-l") 'copy-to-register
                                 (kbd "C-+") 'increment-register
                                 (kbd "<f6>") 'browse-kill-ring
                                 (kbd "C-M-<backspace>") 'paredit-backward-delete
                                 (kbd "<f7>") 'compile))
             '(normal insert))))


;; ;;; Fixes for that insert bug

;; (defadvice eshell-send-input (before switch-to-emacs-mode activate)
;;   (evil-execute-in-emacs-state 1))

;; (defadvice slime-repl-return (before switch-to-emacs-mode activate)
;;   (evil-execute-in-emacs-state 1))
