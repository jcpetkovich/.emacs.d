
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-mode/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-refactor/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'js2-refactor)
(eval-after-load "js2-mode"
  '(progn (define-key js2-mode-map
            (kbd "M-j") 'move-cursor-next-pane)))

(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'setup-js2-mode)
