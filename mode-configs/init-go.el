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
               ("C-c C-d" . godoc-at-point))))

(req-package company-go
  :require go-mode)

(req-package go-eldoc
  :require go-mode
  :config (add-hook 'go-mode-hook 'go-eldoc-setup))
