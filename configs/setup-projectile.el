
(require-package 'projectile)

(projectile-global-mode)

;;; Nicer mode-line

(setq projectile-mode-line-lighter " @")
(defun projectile-update-mode-line ()
  "Report project in mode-line."
  (let* ((project-name (projectile-project-name))
         (message (format "%s[%s]" projectile-mode-line-lighter project-name)))
    (setq projectile-mode-line message))
  (force-mode-line-update))

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
   "*.bib" "*.tex" "*.html" "*.org" "*.md" "*.py" "*.js" "*.sh")
  (set (make-local-variable 'whitespace-cleanup-mode-only-if-initially-clean) nil))

(provide 'setup-projectile)
