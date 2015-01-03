;; init-editing.el - Configure editing related emacs settings.

(setq-default
 ;; Editing
 major-mode                  'org-mode
 indent-tabs-mode            nil
 sentence-end-double-space   nil
 uniquify-buffer-name-style  'post-forward
 save-place                  t
 save-place-file             (concat user-emacs-directory "places")
 lpr-command                 "xpp"
 tags-revert-without-query   t
 tags-table-list             nil
 ediff-window-setup-function 'ediff-setup-windows-plain

 ;; Backups
 backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
 make-backup-files      t
 vc-make-backup-files   t

 ;; Copy and Paste
 x-select-enable-clipboard           t
 x-select-enable-primary             t
 save-interprogram-paste-before-kill t
 mouse-yank-at-point                 t)

(require 'uniquify)
(require 'saveplace)

;;; Make acknowledging stuff faster
(fset 'yes-or-no-p 'y-or-n-p)

;;; Save window configurations
(winner-mode 1)

;; Column number mode
(column-number-mode 1)

;; S for nice string manipulation
(req-package s
  :defer t)

(provide 'init-editing)
