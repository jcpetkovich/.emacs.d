
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete/lib/popup")

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;;; I want autocomplete everywhere
(setq global-auto-complete-mode t)

(dolist (mode '(org-mode text-mode slime-repl-mode LaTeX-mode
                         csv-mode haskell-mode literate-haskell-mode
                         html-mode nxml-mode sh-mode clojure-mode
                         lisp-mode markdown-mode tuareg-mode))
  (add-to-list 'ac-modes mode))

(add-hook 'flyspell-mode-hook
          (lambda ()
            (ac-flyspell-workaround)))

(setq-default ac-sources
              '(ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers
                ac-source-yasnippet))


;;; Make sure autocomplete doesn't interfere with yasnippet.
(setq yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
(setq yas-after-exit-snippet-hook (lambda () (auto-complete-mode 1)))

;; =============================================================
;; Evil Keybindings
;; =============================================================
(eval-after-load "evil"
  '(progn
     ;; Navigation in autocomplete menues gets hijacked by evil
     (define-key ac-completing-map (kbd "C-n") 'ac-next)
     (define-key ac-completing-map (kbd "C-p") 'ac-previous)
     ;; Let me stop autocompleting the emacs/evil way
     (define-key ac-completing-map (kbd "C-g") 'ac-stop)
     (define-key ac-completing-map (kbd "ESC") 'evil-normal-state)
     (evil-make-intercept-map ac-completing-map)))

(provide 'setup-auto-complete)
