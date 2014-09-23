;; =============================================================
;; CEDIT And Semantic
;; =============================================================

;;; setup-cedet-semantic.el - setup cedet and semantic

(require 'semantic)

(global-semanticdb-minor-mode 1)

(setq-default global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(provide 'init-cedet-semantic)

;; =============================================================
;; Flycheck
;; =============================================================

;;; Code:
(require-package 'flycheck)
(require 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)

(setq flycheck-mode-line-lighter " FC")

(setq-default flycheck-checkers
              (-remove (lambda (elem)
                         (-contains? '(emacs-lisp emacs-lisp-checkdoc) elem))
                       flycheck-checkers))

(provide 'init-flycheck)
;;; setup-flycheck.el ends here

;; =============================================================
;; Whitespace
;; =============================================================
(require-package 'whitespace-cleanup-mode)

(require 'whitespace)
(setq whitespace-style (remove 'indentation whitespace-style))

;;; Be nice to git, whitespace where none is necessary or useful is
;;; impolite
(global-whitespace-cleanup-mode)

(add-hook 'makefile-mode-hook (lambda () (whitespace-cleanup-mode -1)))

;;; Don't remove extraneous space at the BOF and EOF please.
(provide 'init-whitespace-mode)

;; =============================================================
;; Projectile
;; =============================================================
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

;; =============================================================
;; Magit
;; =============================================================
(require-package 'magit)

(provide 'init-magit)
