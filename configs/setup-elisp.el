
(require 'setup-evil)
(require-package 'elisp-slime-nav)
(require-package 'info+)
(require-package 'ipretty)
(require-package 'pcomplete-extension)

(global-set-key (kbd "C-h C-j") 'ipretty-last-sexp)
(global-set-key (kbd "C-h C-k") 'ipretty-last-sexp-other-buffer)

(--each '(emacs-lisp-mode-hook ielm-mode-hook)
  (add-hook it 'turn-on-elisp-slime-nav-mode)
  (add-hook it 'eldoc-mode))

(--each '(normal insert)
  (evil-declare-key it emacs-lisp-mode-map
    (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point))

;;; eval region

(defun my-eval-region (start end)
  (interactive "r")
  (eval-region start end)
  (deactivate-mark))

(evil-declare-key 'visual global-map
  (kbd ",") #'my-eval-region)

(provide 'setup-elisp)
