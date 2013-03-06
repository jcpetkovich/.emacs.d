
(add-to-list 'load-path "~/jc-public/site-lisp/js2-mode/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(eval-after-load "js2-mode"
  '(progn
     (evil-declare-key 'normal 'js2-mode-map
       (kbd "M-j") 'move-cursor-next-pane)))
