;; init-rust.el - Setup emacs for editing rust code.

(req-package rust-mode
  :commands rust-mode)

(req-package flycheck-rust
  :require (rust-mode flycheck)
  :config (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))

(provide 'init-rust)
