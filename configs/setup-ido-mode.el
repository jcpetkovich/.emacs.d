
(require 'setup-package)

(require 'ido)
(require 'flx-ido)

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-file-completion-map
              (kbd "C-w") 'ido-delete-backward-word-updir)))

;;; Ignore virtualenv
(add-to-list 'ido-ignore-directories "dev-python")
(add-to-list 'ido-ignore-directories "node_modules")

(ido-mode 1)
(ido-vertical-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

(provide 'setup-ido-mode)

