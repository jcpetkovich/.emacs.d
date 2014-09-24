;; init-dired.el - Configure dired.

(req-package dired
  :require (evil dired-details wdired)
  :config
  (progn
    (require 'dired-details)
    (setq-default dired-details-hidden-string "--- "
                  dired-guess-shell-alist-user '(("\\.pdf\\'" "zathura "))
                  dired-dwim-target t)
    (dired-details-install)

    (defun dired/use-dired-x ()
      (load "dired-x"))

    (add-hook 'dired-load-hook 'dired/use-dired-x)

    (--each '(dired-do-rename
              dired-do-copy
              dired-create-directory
              wdired-abort-changes)
      (eval `(defadvice ,it (after revert-buffer activate)
               (revert-buffer))))

    (defun dired-back-to-start-of-files ()
      (interactive)
      (backward-char (- (current-column) 2)))

    (defun dired-back-to-top ()
      (interactive)
      (beginning-of-buffer)
      (dired-next-line 4))

    (defun dired-jump-to-bottom ()
      (interactive)
      (end-of-buffer)
      (dired-next-line -1))

    (bind-keys :map dired-mode-map
               ("C-a" . dired-back-to-start-of-files)
               ("k" . dired-do-delete)
               ("C-x C-k" . dired-do-delete))

    (define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
    (define-key dired-mode-map (vector 'remap 'smart-up) 'dired-back-to-top)
    (define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
    (define-key dired-mode-map (vector 'remap 'smart-down) 'dired-jump-to-bottom)

    (eval-after-load "wdired"
      '(progn
         (define-key wdired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
         (define-key wdired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
         (define-key wdired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)))

    (evil-declare-key 'normal dired-mode-map
      (kbd "n") 'evil-search-next)))

(provide 'init-dired)
