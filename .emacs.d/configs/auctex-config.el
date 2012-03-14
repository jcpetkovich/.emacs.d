;(add-hook ')
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

;; (add-hook 'LaTeX-mode-hook 
;; 	  (lambda ()
;; 	    (define-key LaTeX-mode-map (kbd "M-<tab>") 'auto-complete)))
