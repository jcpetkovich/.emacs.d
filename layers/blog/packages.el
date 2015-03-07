;;; packages.el --- blog Layer packages File for Spacemacs
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

(defvar blog-packages
  '(
    org-page
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar blog-excluded-packages '()
  "List of packages to exclude.")

(defun blog/init-org-page ()
  "Initialize my package"
  (use-package org-page
    :commands op/do-publication
    :config
    (progn
      (setq op/repository-directory "~/projects/blog/")
      (setq op/site-domain "http://ptk.io/")
      ;; (setq op/personal-disqus-shortname "your_disqus_shortname")
      ;; (setq op/personal-duoshuo-shortname "your_duoshuo_shortname")
      )))
