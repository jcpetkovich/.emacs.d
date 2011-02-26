;; ============================================================= 
;; Scheme options
;; ============================================================= 
;; (require 'slime)
;; (add-to-list 'auto-mode-alist '("\\.rkt\\'" . scheme-mode))
;; ;; (add-to-list 'interpreter-mode-alist '("racket" . scheme-mode))

;; (autoload 'chicken-slime "chicken-slime" "SWANK backend for Chicken" t)

;; ;; If your csi executable is in a non-standard location
;; (setq slime-csi-path "/usr/bin/csi")

;; (add-hook 'scheme-mode-hook
;;           (lambda ()
;;             (slime-mode t)))


(add-to-list 'load-path "~/src/scheme/cluck")

(require 'cluck)

(add-hook 'scheme-mode-hook
          (lambda ()
            (local-set-key (kbd "<tab>") 'scheme-complete-or-indent)))
