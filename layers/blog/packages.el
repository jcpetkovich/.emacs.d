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
    simple-httpd
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar blog-excluded-packages '()
  "List of packages to exclude.")

(defun blog/init-org-page ()
  "Initialize my package"
  (use-package org-page
    :commands op/do-publication
    :init
    (progn
      (defun blog/deploy ()
        (op/git-change-branch op/repository-directory op/repository-html-branch)
        (shell-command (concat "rsync -avz --delete-after "
                        op/repository-directory
                        " root@ptk.io:/var/www/localhost/htdocs") t nil)))
    :config
    (progn
      (setq op/repository-directory (expand-file-name "~/projects/blog/"))
      (setq op/site-domain "http://ptk.io/")
      ;; (setq op/personal-disqus-shortname "your_disqus_shortname")
      ;; (setq op/personal-duoshuo-shortname "your_duoshuo_shortname")
      )))

(defun blog/init-simple-httpd ()
  (use-package simple-httpd
    :defer t
    :init
    (defun blog/preview ()
      (interactive)
      (httpd-serve-directory op/repository-directory))))
