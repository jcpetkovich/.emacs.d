
;; (add-to-list 'load-path "~/jc-personal/site-lisp/ace-jump-mode/")

;; (autoload 'ace-jump-mode "ace-jump-mode")

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal global-map
                       (kbd "SPC") 'ace-jump-mode)))


(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
