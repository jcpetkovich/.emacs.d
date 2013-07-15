
(require 'ido)
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-file-completion-map
              (kbd "C-w") 'ido-delete-backward-word-updir)))

;;; Ignore virtualenv
(add-to-list 'ido-ignore-directories "dev-python")
(add-to-list 'ido-ignore-directories "node_modules")

(provide 'setup-ido-mode)
