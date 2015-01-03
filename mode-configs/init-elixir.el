;; init-elixir.el - Setup emacs for editing elixir code.

(req-package elixir-mode
  :config
  (progn
    (add-to-list 'elixir-mode-hook
                 (defun auto-activate-ruby-end-mode-for-elixir-mode ()
                   (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                        "\\(?:^\\|\\s-+\\)\\(?:do\\)")
                   (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
                   (ruby-end-mode +1)))))

(req-package alchemist
  :require elixir-mode
  :config (setq alchemist-complete-debug-mode nil))

(req-package elixir-yasnippets
  :require elixir-mode
  :init
  (progn
    (elixir-snippets-initialize)))

(provide 'init-elixer)
