;;; setup-multiple-cursors.el - install/configure multiple cursors.

(require-package 'multiple-cursors)

(defvar mc--default-cmds-to-run-once nil)

(global-set-key (kbd "A-C-v A-C-v") 'mc/edit-ends-of-lines)

(global-set-key (kbd "A-C-#") 'mc/insert-numbers)
;;; Next key -> A-C-t (p)
;;  - `mc/markst-next-like-this`: Adds a cursor and region at the next part of the buffer forwards that matches the current region.
(global-set-key (kbd "A-C-t") 'mc/markst-next-like-this)
;;  - `mc/markst-next-word-like-this`: Like `mc/markst-next-like-this` but only for whole words.
(global-set-key (kbd "A-C-S-t") 'mc/markst-next-word-like-this)
;;  - `mc/markst-next-symbol-like-this`: Like `mc/markst-next-like-this` but only for whole symbols.
(global-set-key (kbd "A-C-S-p") 'mc/markst-next-symbol-like-this)

;;; Previous key -> A-C-s (f)
;;  - `mc/markst-previous-like-this`: Adds a cursor and region at the next part of the buffer backwards that matches the current region.
(global-set-key (kbd "A-C-s") 'mc/markst-previous-like-this)
;;  - `mc/markst-previous-word-like-this`: Like `mc/markst-previous-like-this` but only for whole words.
(global-set-key (kbd "A-C-S-s") 'mc/markst-previous-word-like-this)
;;  - `mc/markst-previous-symbol-like-this`: Like `mc/markst-previous-like-this` but only for whole symbols.
(global-set-key (kbd "A-C-S-f") 'mc/markst-previous-symbol-like-this)

;; ### Mark many occurrences

;;; Mark all key -> A-C-a (q)
;;  - `mc/markst-all-like-this`: Marks all parts of the buffer that matches the current region.
(global-set-key (kbd "A-C-a") 'mc/markst-all-like-this)
;;  - `mc/markst-all-words-like-this`: Like `mc/markst-all-like-this` but only for whole words.
(global-set-key (kbd "A-C-S-a") 'mc/markst-all-words-like-this)
;;  - `mc/markst-all-symbols-like-this`: Like `mc/markst-all-like-this` but only for whole symbols.
(global-set-key (kbd "A-C-S-q") 'mc/markst-all-symbols-like-this)

;;; Mark all limited by key -> A-C-r (w) (x)
;;  - `mc/mark-all-in-region`: Prompts for a string to match in the region, adding cursors to all of them.
(global-set-key (kbd "A-C-r") 'mc/mark-all-in-region)
;;  - `mc/mark-all-like-this-in-defun`: Marks all parts of the current defun that matches the current region.
(global-set-key (kbd "A-C-w") 'mc/mark-all-like-this-in-defun)
;;  - `mc/mark-all-words-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole words.
(global-set-key (kbd "A-C-S-w") 'mc/mark-all-words-like-this-in-defun)
;;  - `mc/mark-all-symbols-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole symbols.
(global-set-key (kbd "A-C-x") 'mc/mark-all-symbols-like-this-in-defun)

;;; Mark all god key -> A-C-c
;;  - `mc/mark-all-like-this-dwim`: Tries to be smart about marking everything you want. Can be pressed multiple times.
(global-set-key (kbd "A-C-c") 'mc/mark-all-like-this-dwim)

(defvar my-mc-evil-previous-state nil)

(defun my-mc-evil-switch-to-emacs-state ()
  (when (and (bound-and-true-p evil-mode)
             (region-active-p)
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
