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
        (interactive)
        (op/git-change-branch op/repository-directory op/repository-html-branch)
        (eshell-command (concat "rsync -avz --delete-after "
                                op/repository-directory
                                " root@ptk.io:/var/www/localhost/htdocs") nil)))
    :config
    (progn
      (setq op/repository-directory (expand-file-name "~/projects/blog/"))
      (setq op/site-domain "http://ptk.io/")
      (setq op/personal-github-link "https://github.com/jcpetkovich")
      (setq op/site-main-title "JC's Blog")
      (setq op/site-sub-title "Musings on mostly emacs.")

      (add-to-list 'op/category-config-alist
                   '("cv"
                     :show-meta nil
                     :show-comment nil
                     :uri-generator op/generate-uri
                     :uri-template "/cv/"
                     :sort-by :date
                     :category-index nil)))

    (defun op/verify-git-repository (repo-dir)
      "This function will verify whether REPO-DIR is a valid git repository.
TODO: may add branch/commit verification later."
      (unless (and (file-directory-p repo-dir)
                   (file-exists-p (expand-file-name ".git" repo-dir)))
        (error "Fatal: `%s' is not a valid git repository." repo-dir)))))

(defun blog/init-simple-httpd ()
  (use-package simple-httpd
    :defer t
    :init
    (defun blog/preview ()
      (interactive)
      (httpd-serve-directory op/repository-directory))))
