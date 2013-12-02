
(require-package 'projectile)

(projectile-global-mode)

(defmacro project-specifics (name &rest body)
  (declare (indent 1))
  `(progn
     (add-hook 'find-file-hook
               (lambda ()
                 (when (string-match-p ,name (buffer-file-name))
                   ,@body)))
     (add-hook 'dired-after-readin-hook
               (lambda ()
                 (when (string-match-p ,name (dired-current-directory))
                   ,@body)))))

;;; Emacs config specifics
(project-specifics ".emacs.d"
  (setq ffip-find-options
        (ffip--create-exclude-find-options
         '("site-lisp"
           "elpa"))))

;;; Datamill specifics
(project-specifics "projects/eval-lab"
  (setq ffip-find-options
        (ffip--create-exclude-find-options
         '("dev-python"))))

(provide 'setup-projectile)
