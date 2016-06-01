;;; packages.el --- elisp-extras Layer packages File for Spacemacs
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

(setq elisp-extras-packages
  '(
    paredit
    ipretty
    )
  )

(setq elisp-extras-excluded-packages '())

(defun elisp-extras/prefer-paredit ()
  (smartparens-mode -1)
  (enable-paredit-mode))

(defun kill-region-or-paredit-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-region)
    (call-interactively 'paredit-backward-kill-word)))

(defun elisp-extras/init-paredit ()
  "Initialize my package"
  (use-package paredit
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook 'elisp-extras/prefer-paredit))
    :config
    (progn
      (evil-declare-key 'insert paredit-mode-map
        (kbd "C-k") 'paredit-kill))))

(defun elisp-extras/init-ipretty ()
  "Initialize ipretty"
  (evil-leader/set-key-for-mode 'emacs-lisp-mode
    "ms" 'ipretty-last-sexp))
