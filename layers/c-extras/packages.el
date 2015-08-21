;;; packages.el --- c-extras Layer packages File for Spacemacs
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

(defvar c-extras-packages
  '(
    company
    smart-tabs-mode
    clang-format
    google-c-style
    ycmd
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar c-extras-excluded-packages '()
  "List of packages to exclude.")

(defun c-extras/post-init-company ()
  (use-package company
    :defer t
    :init (add-hook 'c-mode-common-hook
                    (defun c-extras/slow-company-mode ()
                      "Slow down company mode in c-mode like
                      things, it's way too aggressive."
                      (--each '(indentation space-after-tab)
                        (set (make-local-variable 'whitespace-style) (remove it whitespace-style)))))))

(defun c-extras/init-smart-tabs-mode ()
  (use-package smart-tabs-mode
    :init
    (progn
      (defvar c-extras/smart-tabs-enabled nil)
      (add-hook 'c-mode-common-hook
                (defun c-extras/enable-smart-tabs-mode ()
                  (when (not c-extras/smart-tabs-enabled)
                    (setq c-extras/smart-tabs-enabled t)
                    (smart-tabs-insinuate 'c)))))))

(defun c-extras/post-init-ycmd ()
  (use-package ycmd
    :defer t
    :init (setq-default ycmd-server-command '("python" "/home/jcp/labs/ycmd/ycmd/"))))

(defun c-extras/post-init-clang-format ()
  (use-package clang-format
    :defer t
    :commands clang-format-buffer
    :init
    (progn
      (defun clang-format-before-save ()
        (interactive)
        (when (eq major-mode 'c++-mode) (clang-format-buffer)))
      (add-hook 'before-save-hook 'clang-format-before-save))))

(defun c-extras/init-google-c-style ()
  (use-package google-c-style
    :defer t
    :init
    (c-add-style "Google" google-c-style)))
