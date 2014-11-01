;; init-rust.el - Setup emacs for editing rust code.

(req-package racer
  :require company
  :load-path ,(concat site-lisp-directory "/racer/editors/")
  :init (progn
          (setq-default racer-cmd (concat site-lisp-directory "/racer/bin/racer"))
          (setq-default rust-srcpath (expand-file-name "~/test/rust/src/")))
  :config
  (require 'racer))

(req-package rust-mode
  :require (evil)
  :commands rust-mode
  :config
  (progn
    (evil-declare-key 'insert rust-mode-map
      (kbd "'") 'self-insert-command)))

(req-package flycheck-rust
  :require (rust-mode flycheck)
  :config (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))

(provide 'init-rust)
