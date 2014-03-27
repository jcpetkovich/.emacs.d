
(require-package 'auto-complete)
(require 'auto-complete-config)
(require 'setup-evil)

(ac-config-default)

;;; I want autocomplete everywhere
(setq global-auto-complete-mode t
      ac-show-menu-timer 0.1
      ac-auto-show-menu t)

(dolist (mode '(org-mode text-mode slime-repl-mode LaTeX-mode
                         csv-mode haskell-mode literate-haskell-mode
                         html-mode nxml-mode sh-mode clojure-mode
                         lisp-mode markdown-mode tuareg-mode))
  (add-to-list 'ac-modes mode))

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
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

;; Let me stop autocompleting the emacs/evil way
(define-key ac-completing-map (kbd "C-g") 'ac-stop)
(define-key ac-completing-map (kbd "ESC") 'evil-normal-state)
(evil-make-intercept-map ac-completing-map)

(provide 'setup-auto-complete)
