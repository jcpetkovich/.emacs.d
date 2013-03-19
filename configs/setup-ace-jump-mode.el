
(add-to-list 'load-path "~/.emacs.d/site-lisp/ace-jump-mode")


(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Emacs quick move minor mode" t)

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal global-map
                       (kbd "SPC") 'ace-jump-mode)))


(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(provide 'setup-ace-jump-mode)
