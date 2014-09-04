;; =============================================================
;; Slime options
;; =============================================================
(setq inferior-lisp-program "/usr/bin/sbcl --noinform --no-linedit") ; change the default inferior common-lisp interpreter

(setq slime-helper-install "~/quicklisp/slime-helper.el")

(when (file-exists-p slime-helper-install)
  (load slime-helper-install))

(when (require 'slime nil :noerror)
  (require 'slime-autoloads)
  (require 'slime-fancy)
  (setq slime-contribs '(slime-fancy slime-asdf slime-banner))
  (require-package 'slime-company)
  (slime-setup '(slime-company))

  (slime-setup)

  (autoload 'slime-highlight-edits-mode "slime-highlight-edits" nil t)

  (setq common-lisp-hyperspec-root
        (if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
            "file:///usr/share/doc/hyperspec/HyperSpec/"
          "http://www.lispworks.com/reference/HyperSpec/"))

  (defun lisp-enable-paredit-hook () (paredit-mode 1))
  (add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)


  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(iter\\)\\>" 1 font-lock-keyword-face)))

  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(->>\\)\\>" 1 font-lock-keyword-face)))

  (font-lock-add-keywords 'lisp-mode
                          '(("(\\(->\\)\\>" 1 font-lock-keyword-face))))


(provide 'setup-slime)
