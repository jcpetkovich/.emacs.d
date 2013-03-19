
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-file-completion-map
              (kbd "C-w") 'ido-delete-backward-word-updir)))

(provide 'setup-ido-mode)
