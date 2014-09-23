;; init-editing.el - Configure editing related emacs settings.


(setq-default
 indent-tabs-mode                    nil
 save-place                          t
 lpr-command                         "xpp" ; default printing command
 backup-directory-alist              `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
 vc-make-backup-files                t
 save-interprogram-paste-before-kill t
 save-place-file                     (concat user-emacs-directory "places")
 major-mode                          'org-mode)

;;; Make acknowledging stuff faster
(fset 'yes-or-no-p 'y-or-n-p)

;;; Save window configurations
(winner-mode 1)

(provide 'init-editing)
