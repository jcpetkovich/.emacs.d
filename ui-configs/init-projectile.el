
(require-package 'projectile)

(projectile-global-mode)

;; =============================================================
;; Projectile Settings
;; =============================================================

(setq projectile-completion-system 'default)

;;; Nicer mode-line

(defun projectile-update-mode-line ()
  "Report project in mode-line."
  (let* ((message " Projectile"))
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

;;; Datamill specifics
(project-specifics "projects/eval-lab"
  (set (make-local-variable 'whitespace-cleanup-mode-only-if-initially-clean) nil))

(provide 'init-projectile)
