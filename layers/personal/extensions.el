;;; extensions.el --- personal Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar personal-pre-extensions
  '(
    )
  "List of all extensions to load before the packages.")

(defvar personal-post-extensions
  '(
    ;; personals go here
    simple
    recentf
    hippie-expand
    dired
    wdired
    )
  "List of all extensions to load after the packages.")

(defun personal/init-simple ()
  (use-package simple
    :config (setq-default shell-file-name (executable-find "bash"))))

(defun personal/init-recentf ()
  (use-package recentf
    :defer t
    :config
    (setq recentf-max-saved-items 1000
          recentf-auto-cleanup 'mode)))

(defun personal/init-hippie-expand ()
  (use-package hippie-exp
    :bind (("M-/" . hippie-expand)
           ("M-?" . hippie-expand-lines))
    :init
    (progn
      (defun hippie-expand-lines ()
        (interactive)
        (let ((hippie-expand-try-functions-list '(try-expand-list
                                                  try-expand-list-all-buffers
                                                  try-expand-line
                                                  try-expand-line-all-buffers)))
          (hippie-expand nil))))

    :config
    (progn
      (setq-default hippie-expand-dabbrev-skip-space t
                    hippie-expand-try-functions-list
                    '(try-expand-dabbrev
                      try-expand-dabbrev-all-buffers
                      try-expand-dabbrev-from-kill
                      try-complete-file-name-partially
                      try-complete-file-name
                      try-expand-all-abbrevs
                      try-complete-lisp-symbol-partially
                      try-complete-lisp-symbol
                      try-expand-whole-kill
                      try-expand-line))

      (defadvice he-substitute-string (after completion/he-paredit-fix activate)
        "remove extra paren when expanding line in paredit"
        (if (and paredit-mode (equal (substring str -1) ")"))
            (progn (backward-delete-char 1) (forward-char)))))))

(defun personal/init-wdired ()
  (use-package wdired
    :defer t))

(defun personal/init-dired ()
  (use-package dired
    :defer t
    :config
    (progn
      (require 'wdired)
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
        (dired-next-line 3))

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
        (kbd "n") 'evil-search-next))))
