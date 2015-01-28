;; init-ebuild.el - Setup emacs for editing ebuilds

(add-to-list 'auto-mode-alist '("\\.\\(ebuild\\|eclass\\)$" . sh-mode))

(add-hook 'sh-mode-hook (lambda ()
                          (when (string-match "\\.ebuild$" (buffer-file-name))
                            (sh-set-shell "bash"))))

(provide 'init-ebuild)
