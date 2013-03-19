;; =============================================================
;; Slime options
;; =============================================================
(setq inferior-lisp-program "/usr/bin/sbcl --noinform --no-linedit") ; change the default inferior common-lisp interpreter
 
(defun lisp-enable-paredit-hook () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(font-lock-add-keywords 'lisp-mode
  '(("(\\(iter\\)\\>" 1 font-lock-keyword-face)))

(font-lock-add-keywords 'lisp-mode
  '(("(\\(->>\\)\\>" 1 font-lock-keyword-face)))

(font-lock-add-keywords 'lisp-mode
  '(("(\\(->\\)\\>" 1 font-lock-keyword-face)))


(provide 'setup-slime)
