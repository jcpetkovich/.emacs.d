;; init-editing.el - Configure editing related emacs settings.

(setq-default
 indent-tabs-mode                    nil
 save-place                          t
 lpr-command                         "xpp" ; default printing command
 backup-directory-alist              `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
 make-backup-files                   t
 vc-make-backup-files                t
 save-interprogram-paste-before-kill t
 save-place-file                     (concat user-emacs-directory "places")
 tags-revert-without-query           t
 tags-table-list nil
 uniquify-buffer-name-style          'post-forward
 x-select-enable-clipboard           t
 x-select-enable-primary             t
 major-mode                          'org-mode)

(require 'uniquify)
(require 'saveplace)

;;; Make acknowledging stuff faster
(fset 'yes-or-no-p 'y-or-n-p)

;;; Save window configurations
(winner-mode 1)

;; S for nice string manipulation

(req-package s
  :defer t)

(provide 'init-editing)
