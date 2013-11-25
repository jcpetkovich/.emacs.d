

(require 'paredit)
(require 'setup-dash)


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


(require 'smartparens-config)

;;; Laying paredit bindings on top of the smartparents one, not very
;;; pretty but this includes all the functions that I want to use.
(sp-use-smartparens-bindings)
(sp-use-paredit-bindings)
(setq sp-autoescape-string-quote nil)
(setq sp-autoskip-closing-pair 'always)
(setq sp-cancel-autoskip-on-backward-movement nil)

(--each '(css-mode-hook
          markdown-mode-hook
          python-mode-hook
          sh-mode-hook
          ess-mode-hook
          haskell-mode-hook
          c-mode-hook
          LaTeX-mode-hook
          org-mode-hook
          sgml-mode-hook)
  (add-hook it 'turn-on-smartparens-strict-mode))

(provide 'setup-paredit)
