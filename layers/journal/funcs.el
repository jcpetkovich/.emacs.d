;;; keybindings.el --- Journal Layer funcs File
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/jcpetkovich/.emacs.d
;;
;; This file is not part of GNU Emacs.
;;
;; add journal funcs

(defun journal/find-bullet-journal ()
  (concat journal/entries "/" (format-time-string "%Y-%m-%d") ".org"))

(defun journal/find-and-hide-log ()
  (set-buffer (find-file-noselect (journal/find-bullet-journal)))
  (goto-char (point-min)))

(defun journal/open-todays-log ()
  (interactive)
  (find-file-other-window (journal/find-bullet-journal)))

(defun journal/migrate ()
  (interactive)
  (let ((old-todo-state (org-get-todo-state)))
    (save-excursion
      (journal/find-and-hide-log)
      (let ((buffer-has-no-headings
             (condition-case err
                 (progn (re-search-forward "^\*")
                        nil)
               (error t))))

        (when buffer-has-no-headings
          (goto-char (point-min))
          (insert "* Personal\n* Work\n"))))

    (let ((org-refile-targets '((journal/find-bullet-journal :level . 1))))
      (when (equal old-todo-state "DONE")
        (org-todo "TODO"))
      (org-copy)
      (if (equal old-todo-state "DONE")
          (org-todo "DONE")
        (org-todo "MIGR")))))

