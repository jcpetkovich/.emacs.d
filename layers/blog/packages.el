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
    :commands (op/do-publication op/new-post)
    :init
    (progn
      (defun blog/deploy ()
        (interactive)
        (op/git-change-branch op/repository-directory op/repository-html-branch)
        (eshell-command (concat "rsync -avz --delete-after "
                                op/repository-directory
                                " root@ptk.io:/var/www/localhost/htdocs") nil))

      (defvar blog/org-inline-css-hook-called nil)

      (defun blog/org-inline-css-hook (exporter)
        "Insert custom inline css to automatically set the
background of code to whatever theme I'm using's background"
        (when (and (not blog/org-inline-css-hook-called) (eq exporter 'html))
          (let* ((my-pre-bg (face-background 'default))
                 (my-pre-fg (face-foreground 'default)))
            (setq blog/org-inline-css-hook-called t)
            (setq
             org-html-head-extra
             (concat
              org-html-head-extra
              (format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
                      my-pre-bg my-pre-fg)))))))
    :config
    (progn
      (setq op/repository-directory (expand-file-name "~/projects/blog/"))
      (setq op/site-domain "http://ptk.io/")
      (setq op/personal-github-link "https://github.com/jcpetkovich")
      (setq op/site-main-title "JC's Blog")
      (setq op/site-sub-title "Musings on (mostly) emacs.")
      (setq op/theme 'mytheme)
      (setq op/theme-root-directory (concat op/repository-directory "themes/"))

      ;; Add hook to grab background color for org css output
      (add-hook 'org-export-before-processing-hook 'blog/org-inline-css-hook)

      (add-to-list 'op/category-config-alist
                   '("cv"
                     :show-meta nil
                     :show-comment nil
                     :uri-generator op/generate-uri
                     :uri-template "/cv/"
                     :sort-by :date
                     :category-index nil))

      (defun op/render-content (&optional template param-table)
        "My patched version of op/render-content to use org as a backend for css."
        (mustache-render
         (op/get-cache-create
          (if template
              (intern (replace-regexp-in-string "\\.mustache$" "-template" template))
            :post-template)
          (message (concat "Read " (or template "post.mustache") " from file"))
          (file-to-string (concat op/template-directory
                                  (or template "post.mustache"))))
         (or param-table
             (ht ("title" (or (op/read-org-option "TITLE") "Untitled"))
                 ("content" (org-export-as 'html nil nil t nil))))))

      (defadvice op/do-publication (before blog/ensure-lang-syntax-loaded activate)
        ;; Trigger load of language configurations
        (load-ess-on-demand)
        (require 'python)))

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
