;; init-elixir.el - Setup emacs for editing elixir code.

(req-package elixir-mode)

(req-package alchemist
  :require elixir-mode
  :config (setq alchemist-complete-debug-mode nil))

(req-package elixir-yasnippets
  :require elixir-mode
  :init
  (progn
    (elixir-snippets-initialize)))

(provide 'init-elixer)
