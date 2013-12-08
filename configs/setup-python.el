
(require-package 'jedi)
(require-package 'ein)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
          (lambda ()
            (-each '(normal insert)
                   (lambda (mode) (evil-declare-key mode python-mode-map
                                    (kbd "M-.") 'jedi:goto-definition
                                    (kbd "M-,") 'jedi:goto-definition-pop-marker)))))

(provide 'setup-python)
