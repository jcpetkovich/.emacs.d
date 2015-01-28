;; silly-keys.el - Provide silly modern keys.

(define-minor-mode silly-keys
  "Define silly modern keys for when people use my editor to show
me something."
  :keymap (make-sparse-keymap)
  (if silly-keys
      (progn
        (cua-mode 1)
        (evil-emacs-state))
    (cua-mode -1)
    (evil-normal-state)))

(let ((map silly-keys-map))
  (define-key map (kbd "C-s") 'save-buffer)
  (define-key map (kbd "C-f") 'helm-swoop-custom)
  (define-key map (kbd "C-S-f") 'helm-cmd-t-grep)
  (define-key map (kbd "C-o") 'helm-find-files)
  (define-key map (kbd "C-S-o") 'helm-browse-project)
  (define-key map (kbd "C-t") 'helm-cmd-t)
  (define-key map (kbd "C-d") 'user-mc/expand-or-mark-next-symbol)
  (define-key map (kbd "M-r") 'helm-semantic-or-imenu)
  (define-key map (kbd "M-S-r") 'helm-gtags-select)
  (define-key map (kbd "C-y") 'undo-tree-redo)
  (define-key map (kbd "C-z") 'undo-tree-undo)
  (define-key map (kbd "C-a") 'mark-whole-buffer))

(provide 'silly-keys)
