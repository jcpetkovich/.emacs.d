
(require-package 'elisp-slime-nav)

(--each '(emacs-lisp-mode-hook ielm-mode-hook)
  (add-hook it 'turn-on-elisp-slime-nav-mode)
  (add-hook it 'eldoc-mode))

(eval-after-load "evil"
  '(progn
     (--each '(normal insert)
       (evil-declare-key it emacs-lisp-mode-map
         (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point))))

(provide 'setup-elisp)
