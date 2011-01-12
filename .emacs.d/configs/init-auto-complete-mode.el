(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq global-auto-complete-mode t)

(dolist (mode '(org-mode text-mode 
                csv-mode haskell-mode literate-haskell-mode
                html-mode nxml-mode sh-mode clojure-mode
                lisp-mode markdown-mode tuareg-mode))
  (add-to-list 'ac-modes mode))

(eval-after-load "viper"
  '(progn
     (define-key ac-completing-map (kbd "C-n") 'ac-next)
     (define-key ac-completing-map (kbd "C-p") 'ac-previous)
     (define-key ac-completing-map (kbd "C-g") 'ac-stop)
     (define-key ac-completing-map viper-ESC-key 'viper-intercept-ESC-key)))


