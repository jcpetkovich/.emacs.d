;; init-programming.el - Programming related configurations.

;; =============================================================
;; Simple
;; =============================================================
(req-package simple
  ;; Prefer bash over user shell
  :config (setq-default shell-file-name (executable-find "bash")))

;; =============================================================
;; CEDIT and Semantic
;; =============================================================

(req-package semantic
  :init (progn
          (global-semanticdb-minor-mode 1)
          (setq-default global-semantic-idle-scheduler-mode 1)
          (semantic-mode 1)))

;; =============================================================
;; Flycheck
;; =============================================================

(req-package flycheck
  :commands flycheck-mode
  :init (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (progn
    (setq-default flycheck-mode-line-lighter " FC"
                  flycheck-checkers
                  (-remove (lambda (elem)
                             (-contains? '(emacs-lisp emacs-lisp-checkdoc) elem))
                           flycheck-checkers))))

;; =============================================================
;; Whitespace
;; =============================================================
(req-package whitespace-cleanup-mode
  :require whitespace
  :config
  (progn
    (setq-default whitespace-style (remove 'indentation whitespace-style))

    (global-whitespace-cleanup-mode)
    (add-hook 'makefile-mode-hook (lambda () (whitespace-cleanup-mode -1)))))

;; =============================================================
;; Projectile
;; =============================================================
(req-package projectile
  :commands projectile-global-mode
  :idle (projectile-global-mode)
  :config
  (progn
    (setq-default projectile-completion-system 'default
                  projectile-enable-caching t)

    (bind-key "<f6>" 'projectile-compile-project)

    ;; Nicer mode-line
    (defun projectile-update-mode-line ()
      "Report project in mode-line."
      (let* ((message " Projectile"))
        (setq projectile-mode-line message))
      (force-mode-line-update))))

;; =============================================================
;; Project Specifics
;; =============================================================
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

;; Datamill specifics
(project-specifics "projects/eval-lab"
  (set (make-local-variable 'whitespace-cleanup-mode-only-if-initially-clean) nil))

;; DWM specifics
(project-specifics "dwm.*[c|h]$"
  (user-cc/default-include-path '("/usr/include" "/usr/include/freetype2" "."))
  (user-cc/default-includes '("/usr/include/X11/Xutil.h" "dwmstatus.h")))

(project-specifics "dwmstatus"
  (user-cc/default-include-path '("/usr/include" "/usr/include/freetype2" "."
                                  "/usr/include/glib-2.0/" "/usr/lib64/glib-2.0/include" ))
  (user-cc/default-includes '("/usr/include/X11/Xutil.h" "dwmstatus.h")))

;; =============================================================
;; Magit
;; =============================================================
(req-package magit
  :require evil-leader
  :commands magit-status
  :config
  (progn
    (defadvice magit-show-level-4 (after user-magit/center-after-move activate)
      (recenter))
    (defadvice magit-goto-next-sibling-section (after user-magit/center-after-move activate)
      (recenter))
    (defadvice magit-goto-previous-sibling-section (after user-magit/center-after-move activate)
      (recenter))

    (evil-leader/set-key
      "gb" 'magit-blame-mode
      "gl" 'magit-log
      "gs" 'magit-status
      "gC" 'magit-commit)))

(req-package github-browse-file
  :require evil-leader
  :init
  (progn
    (user-leader/declare-prefix "gf" "github")
    (evil-leader/set-key "gfb" 'github-browse-file)))

(req-package gist
  :require evil-leader
  :init
  (progn
    (user-leader/declare-prefix "gg" "gist")
    (evil-leader/set-key
      "ggb" 'gist-buffer
      "ggB" 'gist-buffer-private
      "ggl" 'gist-list
      "ggr" 'gist-region
      "ggR" 'gist-region-private)))

(req-package git-gutter
  :require evil-leader
  :init
  (progn
    (user-leader/declare-prefix "gh" "git-gutter")
    (evil-leader/set-key
      "ghs" 'git-gutter:stage-hunk
      "ghr" 'git-gutter:revert-hunk
      "ghN" 'git-gutter:previous-hunk
      "ghn" 'git-gutter:next-hunk)))

(req-package git-messenger
  :require evil-leader
  :init
  (evil-leader/set-key "gm" 'git-messenger:popup-message))

(req-package git-timemachine
  :require evil-leader
  :init
  (evil-leader/set-key "gt" 'git-timemachine))

(req-package smeargle
  :require evil-leader
  :init
  (evil-leader/set-key
    "ghc" 'smeargle-clear
    "ghh" 'smeargle-commits
    "ght" 'smeargle))

;; =============================================================
;; Refactoring
;; =============================================================

(req-package emr
  :commands emr-initialize
  :init (add-hook 'prog-mode-hook 'emr-initialize))

;; =============================================================
;; gnu global
;; =============================================================
(req-package ggtags)

(req-package helm-gtags
  :require (helm evil)
  :config
  (progn
    (--each '(normal insert)
      (evil-declare-key it helm-gtags-mode-map
        (kbd "M-.") 'helm-gtags-dwim
        (kbd "M-,") 'helm-gtags-pop-stack))

    (--each '(c-mode-hook
              c++-mode-hook
              coffee-mode-hook
              cperl-mode-hook
              sh-mode-hook)
      (add-hook it 'helm-gtags-mode))))

(provide 'init-programming)
