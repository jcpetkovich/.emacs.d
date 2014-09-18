(require 'init-evil)
(require-package 'paredit)
(require-package 'smartparens)

(require 'paredit)
(require 'smartparens-config)

(let ((turn-on-paredit-mode (lambda () (paredit-mode 1))))
  ;; some hooks: lisp-mode-hook and scheme-mode-hook are recommended
  ;; in the paredit source code
  (--each '(lisp-mode-hook scheme-mode-hook emacs-lisp-mode-hook slime-mode-hook cider-repl-mode-hook)
    (add-hook it turn-on-paredit-mode)))

(defadvice paredit-close-round (after paredit-close-and-indent activate)
  (cleanup-buffer))

;;; Laying paredit bindings on top of the smartparents one, not very
;;; pretty but this includes all the functions that I want to use.
(sp-use-smartparens-bindings)
(sp-use-paredit-bindings)
(setq-default sp-autoescape-string-quote nil)
(setq-default sp-autoskip-closing-pair 'always)
(setq-default sp-cancel-autoskip-on-backward-movement nil)

(evil-declare-key 'insert paredit-mode-map
  (kbd "C-k") 'paredit-kill)

(--each '(css-mode-hook
          markdown-mode-hook
          python-mode-hook
          sh-mode-hook
          ess-mode-hook
          haskell-mode-hook
          c-mode-hook
          LaTeX-mode-hook
          org-mode-hook
          sgml-mode-hook
          awk-mode-hook)
  (add-hook it 'turn-on-smartparens-strict-mode))

;;; Have to force some modes, as they are based on comint-mode
(--each '(inferior-ess-mode-hook)
  (add-hook it 'smartparens-mode))

;;; Fix smartparens-strict-mode-map for evil:
(evil-define-key 'insert smartparens-strict-mode-map
  (kbd "DEL") #'sp-backward-delete-char)

(evil-declare-key 'insert paredit-mode-map
  (kbd "C-w") 'paredit-backward-kill-word)

(provide 'init-paredit)
