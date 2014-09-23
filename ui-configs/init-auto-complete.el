
(require-package 'auto-complete)
(require 'auto-complete-config)
(require 'init-evil)

(setq ac-show-menu-timer 0.1
      ac-auto-show-menu t)

(add-hook 'flyspell-mode-hook
          (lambda ()
            (ac-flyspell-workaround)))

;;; Make sure autocomplete doesn't interfere with yasnippet.
(setq yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
(setq yas-after-exit-snippet-hook (lambda () (auto-complete-mode 1)))

;; =============================================================
;; Evil Keybindings
;; =============================================================

;; Navigation in autocomplete menues gets hijacked by evil
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-p") 'ac-previous)

;; Let me stop autocompleting the emacs/evil way
(define-key ac-completing-map (kbd "C-g") 'ac-stop)
(define-key ac-completing-map (kbd "ESC") 'evil-normal-state)
(evil-make-intercept-map ac-completing-map)

(provide 'init-auto-complete)
