;; init-go.el - Setup emacs for editing go code.

(req-package go-mode
  :config
  (progn
    (--each '(normal insert)
      (evil-declare-key it go-mode-map
        (kbd "M-.") 'godef-jump))

    (bind-keys :map go-mode-map
               ("M-," . pop-tag-mark)
               ("M-." . godef-jump)
               ("C-c C-d" . godoc-at-point))
    (add-hook 'before-save-hook 'gofmt-before-save)

    (add-hook 'go-mode-hook
              (defun user-go/setup-compile ()
                (if (not (string-match "go" compile-command))
                    (set (make-local-variable 'compile-command)
                         "go build -v && go test -v && go vet"))))))

(req-package company-go
  :require go-mode)

(req-package go-eldoc
  :require go-mode
  :config (add-hook 'go-mode-hook 'go-eldoc-setup))
