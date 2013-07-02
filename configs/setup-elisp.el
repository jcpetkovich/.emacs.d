
(require 'setup-dash)
(require 'dash)

(--each '(emacs-lisp-mode-hook ielm-mode-hook)
  (add-hook it 'turn-on-elisp-slime-nav-mode))

(eval-after-load "evil"
  '(progn
     (--each (list 'normal 'insert)
	     (evil-declare-key it emacs-lisp-mode-map
			       (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point))))

(provide 'setup-elisp)
