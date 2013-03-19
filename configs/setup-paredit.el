

(require 'paredit)


(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(let ((turn-on-paredit-mode (lambda () (paredit-mode 1))))
  ;; some hooks: lisp-mode-hook and scheme-mode-hook are recommended
  ;; in the paredit source code
  (add-hook 'lisp-mode-hook turn-on-paredit-mode)
  (add-hook 'scheme-mode-hook turn-on-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook turn-on-paredit-mode)
  (add-hook 'slime-mode-hook turn-on-paredit-mode))


(defadvice paredit-close-round (after paredit-close-and-indent activate)
  (cleanup-buffer))

(provide 'setup-paredit)
