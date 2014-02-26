;;; setup-diminish.el -*- lexical-binding: t; -*-

(require-package 'diminish)

(defun diminish-major (mode new-string)
  "Diminish the major mode. It will only diminish the major mode
such that the string is shorter, not so that it does not appear
at all like the regular `diminish' function. It uses
lexical-binding to create a proper closure."

  (let ((mode-hook (intern (s-concat (symbol-name mode) "-hook"))))
    (add-hook mode-hook (lambda () (setq mode-name new-string)))))

(eval-after-load "paredit"
  '(diminish 'paredit-mode "p()"))

(eval-after-load "smartparens"
  '(diminish 'smartparens-mode "s()"))

(eval-after-load "flyspell"
  '(diminish 'flyspell-mode " FS"))

(diminish-major 'emacs-lisp-mode "Elisp")

(provide 'setup-diminish)
