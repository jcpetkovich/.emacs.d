;; =============================================================
;; Slime options
;; =============================================================
(setq inferior-lisp-program "/usr/bin/sbcl --noinform --no-linedit") ; change the default inferior common-lisp interpreter

(when (require 'slime nil :noerror)
  (require 'slime-autoloads)

  (slime-setup)

  (autoload 'slime-highlight-edits-mode "slime-highlight-edits" nil t)

  (setq common-lisp-hyperspec-root
        (if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
            "file:///usr/share/doc/hyperspec/HyperSpec/"
          "http://www.lispworks.com/reference/HyperSpec/"))

  (defun lisp-enable-paredit-hook () (paredit-mode 1))
  (add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)

  (require 'ac-slime)
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'slime-repl-mode))

  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(iter\\)\\>" 1 font-lock-keyword-face)))

  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(->>\\)\\>" 1 font-lock-keyword-face)))

  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(->\\)\\>" 1 font-lock-keyword-face))))


(provide 'setup-slime)
