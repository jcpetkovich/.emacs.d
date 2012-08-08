
(add-to-list 'load-path "~/jc-personal/site-lisp/ace-jump-mode/")

(require 'ace-jump-mode)

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal global-map
                       (kbd "SPC") 'ace-jump-mode)))


