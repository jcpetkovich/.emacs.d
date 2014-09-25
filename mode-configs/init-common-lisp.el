;; init-common-lisp.el - Setup emacs for editing common lisp.

;; Bootstrap common lisp
(setq-default inferior-lisp-program "/usr/bin/sbcl --noinform --no-linedit"
      slime-helper-install "~/quicklisp/slime-helper.el")

(when (file-exists-p slime-helper-install)
  (load slime-helper-install))

;; If we loaded slime, set it up
(when (require 'slime-autoloads nil :noerror)

  (req-package slime-company
    :require slime
    :config (slime-setup '(slime-company)))

  (req-package slime
    :commands slime
    :config
    (progn
      (require 'slime-fancy)

      (setq-default slime-contribs '(slime-fancy slime-asdf slime-banner)
                    common-lisp-hyperspec-root
                    (if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
                        "file:///usr/share/doc/hyperspec/HyperSpec/"
                      "http://www.lispworks.com/reference/HyperSpec/"))

      (slime-setup)

      (autoload 'slime-highlight-edits-mode "slime-highlight-edits" nil t)

      (font-lock-add-keywords 'lisp-mode
                              '(("(\\(iter\\)\\>" 1 font-lock-keyword-face)))

      (font-lock-add-keywords 'lisp-mode
                              '(("(\\(->>\\)\\>" 1 font-lock-keyword-face)))

      (font-lock-add-keywords 'lisp-mode
                              '(("(\\(->\\)\\>" 1 font-lock-keyword-face))))))

(provide 'init-common-lisp)
