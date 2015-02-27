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
    company-mode
    smart-tabs-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar c-extras-excluded-packages '()
  "List of packages to exclude.")

(defun c-extras/init-company-mode ()
  (use-package company-mode
    :defer t
    :init (add-hook 'c-mode-common-hook
                    (defun c-extras/slow-company-mode ()
                      "Slow down company mode in c-mode like
                      things, it's way too aggressive."
                      (set (make-local-variable 'company-idle-delay) 1)))))

(defun c-extras/init-smart-tabs-mode ()
  (use-package smart-tabs-mode
    :init
    (progn
      (defvar c-extras/smart-tabs-enabled nil)
      (add-hook 'c-mode-common-hook
                (defun c-extras/enable-smart-tabs-mode ()

                  (when (not c-extras/smart-tabs-enabled)
                    (setq c-extras/smart-tabs-enabled t)
                    (smart-tabs-insinuate 'c 'c++)))))))
