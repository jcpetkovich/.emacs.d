
(add-to-list 'auto-mode-alist '("\\.ebuild$" . sh-mode))

(add-hook 'sh-mode-hook (lambda ()
                          (when (string-match "\\.ebuild$" (buffer-file-name))
                            (sh-set-shell "bash"))))
