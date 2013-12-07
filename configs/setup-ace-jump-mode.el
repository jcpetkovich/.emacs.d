
(require-package 'ace-jump-mode)

(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Emacs quick move minor mode" t)

(eval-after-load "evil"
  '(progn
     (--each '(normal visual movement)
       (evil-declare-key it global-map
         (kbd "SPC") 'evil-ace-jump-word-mode
         (kbd "C-SPC") 'evil-ace-jump-line-mode))))


(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(provide 'setup-ace-jump-mode)
