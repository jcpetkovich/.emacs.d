;;; packages.el --- journal Layer packages File for Spacemacs
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

(setq journal-packages
      '(
        (org :location built-in)
        org-caldav
        )
      )

(setq journal-excluded-packages '())

(defun journal/post-init-org ()
  (use-package org
    :commands (org-mode)
    :defer t
    :init
    (setq-default
     org-directory           "~/journal"
     journal/entries        (concat org-directory "/entries")
     org-agenda-files        (list org-directory)
     org-archive-location    (concat org-directory "/archive.org::* Finished Tasks")
     org-mobile-directory    (concat org-directory "/webdav")

     org-todo-keywords '((sequence "TODO(t)" "PROG(p)" "|" "MIGR(m)" "DONE(d)" "DEFERRED(f)"))
     org-src-fontify-natively t
     org-completion-use-ido t
     org-default-notes-file (concat org-directory "/captured.org")
     org-file-apps '((auto-mode . emacs)
                     ("\\.mm\\'" . default)
                     ("\\.x?html?\\'" . default)
                     ("\\.pdf\\'" . "zathura %s"))



     remember-annotation-functions '(org-remember-annotation)
     remember-handler-functions '(org-remember-handler)
     my-notes-file (concat org-directory "/commonplace.org")

     org-capture-templates
     '(("g" "General Inbox" entry (file+headline my-notes-file "Inbox")
        "* %?\n%u\n%a\n%i")
       ("t" "Task" entry (function journal/find-and-hide-log)
        "* TODO %?\n%u\n%a\n%i")
       ("n" "Note" entry (function journal/find-and-hide-log)
        "* %?\n%u\n%a\n%i"))
     org-startup-indented t)

    :config
    (progn
      (evil-leader/set-key-for-mode 'org-mode
        "mM" 'journal/migrate)
      (add-hook 'remember-mode-hook 'org-remember-apply-template)

      (add-to-list 'org-modules 'org-timer)
      (add-to-list 'org-modules 'org-habit)

      (add-hook 'org-mode-hook (defun journal/org-bullets ()
                                 (org-bullets-mode 1))))))




;; For each package, define a function journal/init-<package-journal>
;;
;; (defun journal/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
