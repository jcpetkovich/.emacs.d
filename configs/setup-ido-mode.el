
;; (require 'ido)
;; (require-package 'flx-ido)
;; (require-package 'ido-vertical-mode)

;; (add-hook 'ido-setup-hook
;;           (lambda ()
;;             (define-key ido-file-completion-map
;;               (kbd "C-w") 'ido-delete-backward-word-updir)))

;; ;;; Ignore virtualenv
;; (add-to-list 'ido-ignore-directories "dev-python")
;; (add-to-list 'ido-ignore-directories "node_modules")

;; (ido-mode 1)
;; (ido-vertical-mode 1)
;; (ido-everywhere 1)
;; (flx-ido-mode 1)
;; ;;; disable ido faces to see flx highlights.
;; (setq ido-use-faces nil)

;; ;;; Raise file/buffer right where I ask for it please
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)

;; (provide 'setup-ido-mode)
