;; init-elisp.el - Setup emacs for editing elisp.

(req-package lisp-mode
  :require (elisp-slime-nav info+ ipretty pcomplete-extension evil)
  :bind (("C-h C-j" . ipretty-last-sexp)
         ("C-h C-k" . ipretty-last-sexp-other-buffer))
  :init
  (progn
    (--each '(emacs-lisp-mode-hook ielm-mode-hook)
      (add-hook it 'turn-on-elisp-slime-nav-mode)
      (add-hook it 'eldoc-mode)))

  :config
  (progn
    (dash-enable-font-lock)
    (--each '(normal insert)
      (evil-declare-key it emacs-lisp-mode-map
        (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point))

    (defun user-elisp/my-eval-region (start end)
      (interactive "r")
      (eval-region start end)
      (deactivate-mark))

    (evil-declare-key 'visual global-map
      (kbd ",") #'user-elisp/my-eval-region)))

(provide 'init-elisp)
