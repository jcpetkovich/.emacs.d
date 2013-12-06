
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
  (ffip-local-excludes
   "site-lisp"
   "elpa"))

;;; Datamill specifics
(project-specifics "projects/eval-lab"
  (ffip-local-excludes
   "dev-python"
   "packages"
   "master/datamill_website/migrations")
  (ffip-local-patterns
   "*.bib" "*.tex" "*.html" "*.org" "*.md" "*.py" "*.js" "*.sh"))

(provide 'setup-projectile)
