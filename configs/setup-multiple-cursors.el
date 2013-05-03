
(add-to-list 'load-path "~/.emacs.d/site-lisp/multiple-cursors/")

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-#") 'mc/insert-numbers)

(defvar my-mc-evil-previous-state nil)

(defun my-mc-evil-switch-to-emacs-state ()
  (when (and (bound-and-true-p evil-mode)
             (not (memq evil-state '(insert emacs))))
    (setq my-mc-evil-previous-state evil-state)
    (let ((mark-before (mark))
          (point-before (point)))

      (evil-emacs-state 1)
      (goto-char point-before)
      (set-mark mark-before))))

(defun my-mc-evil-back-to-previous-state ()
  (when my-mc-evil-previous-state
    (unwind-protect
        (case my-mc-evil-previous-state
          ((normal visual) (evil-force-normal-state))
          (t (message "Don't know how to handle previous state: %S"
                      my-mc-evil-previous-state)))
      (setq my-mc-evil-previous-state nil))))

(add-hook 'multiple-cursors-mode-enabled-hook
          'my-mc-evil-switch-to-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook
          'my-mc-evil-back-to-previous-state)

(defun my-rrm-evil-switch-state ()
  (if rectangular-region-mode
      (my-mc-evil-switch-to-emacs-state)
    (setq my-mc-evil-previous-state nil)))

;;; When running edit-lines, point will return (position + 1) as a
;;; result of how evil deals with regions
(defadvice mc/edit-lines (before change-point-by-1 activate)
  (goto-char (1- (point))))

(add-hook 'rectangular-region-mode-hook 'my-rrm-evil-switch-state)

(provide 'setup-multiple-cursors)
