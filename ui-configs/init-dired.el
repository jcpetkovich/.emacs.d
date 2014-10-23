;; init-dired.el - Configure dired.

(req-package dired
  :require (evil wdired)
  :config
  (progn
    (setq-default dired-hide-details-hide-symlink-targets nil
                  dired-guess-shell-alist-user '(("\\.pdf\\'" "zathura "))
                  dired-dwim-target t)

    (defun dired/use-dired-x ()
      (load "dired-x"))

    (add-hook 'dired-load-hook 'dired/use-dired-x)
    (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

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

    (bind-keys :map dired-mode-map
               ([remap beginning-of-buffer] . dired-back-to-top)
               ([remap smart-up] . dired-back-to-top)
               ([remap end-of-buffer] . dired-jump-to-bottom)
               ([remap smart-down] . dired-jump-to-bottom))

    (bind-keys :map wdired-mode-map
               ("C-a" . dired-back-to-start-of-files)
               ([remap beginning-of-buffer] . dired-back-to-top)
               ([remap end-of-buffer] . dired-jump-to-bottom))

    (evil-declare-key 'normal dired-mode-map
      (kbd "n") 'evil-search-next)))

(provide 'init-dired)
