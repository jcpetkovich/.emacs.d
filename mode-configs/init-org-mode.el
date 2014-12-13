;; init-org-mode.el - Setup emacs for editing org files.

;; Do not use bundled org mode. Must happen before other packages call org.
(when (not (package-installed-p 'org '(20140929)))
  (when (not (assoc 'org package-archive-contents))
    (package-refresh-contents))
  (package-install 'org))

(req-package org
  :require evil
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb))
  :commands org-mode
  :config
  (progn

    (defun user-org/find-bullet-journal ()
      (concat user-org/entries "/" (format-time-string "%Y-%m-%d") ".org"))

    (defun user-org/find-and-hide-log ()
      (set-buffer (find-file-noselect (user-org/find-bullet-journal)))
      (goto-char (point-min)))

    (defun user-org/open-todays-log ()
      (interactive)
      (find-file-other-window (user-org/find-bullet-journal)))

    (defun user-org/migrate ()
      (interactive)
      (let ((old-todo-state (org-get-todo-state)))
        (save-excursion
          (user-org/find-and-hide-log)
          (let ((buffer-has-no-headings
                 (condition-case err
                     (progn (re-search-forward "^\*")
                            nil)
                   (error t))))

            (when buffer-has-no-headings
              (goto-char (point-min))
              (insert "* Personal\n* Work\n"))))

        (let ((org-refile-targets '((user-org/find-bullet-journal :level . 1))))
          (when (equal old-todo-state "DONE")
            (org-todo "TODO"))
          (org-copy)
          (if (equal old-todo-state "DONE")
              (org-todo "DONE")
            (org-todo "MIGR")))))

    (add-hook 'remember-mode-hook 'org-remember-apply-template)

    (bind-keys
     ("C-c c" . org-capture)
     ("C-c l" . org-store-link)
     ("C-c m" . user-org/migrate))

    (bind-keys :map org-mode-map
               ("C-c /" . org-sparse-tree)
               ("C-M-l" . org-metaright)
               ("C-M-h" . org-metaleft)
               ("C-M-k" . org-metaup)
               ("C-M-j" . org-metadown)
               ("C-M-S-l" . org-shiftmetaright)
               ("C-M-S-h" . org-shiftmetaleft)
               ("C-M-S-k" . org-shiftmetaup)
               ("C-M-S-j" . org-shiftmetadown))

    ;; Fix for expand region
    (--each '(normal emacs visual insert)
      (evil-declare-key it org-mode-map
        (kbd "C-'") 'er/expand-region))

    (--each '(normal emacs insert)
      (evil-declare-key it org-mode-map
        (kbd "<M-down>") 'org-metadown
        (kbd "<M-up>") 'org-metaup))

    (add-to-list 'org-modules 'org-timer)
    (add-to-list 'org-modules 'org-habit)


    (setq-default
     org-hide-leading-stars  t
     org-odd-levels-only     t
     org-directory           "~/journal"
     user-org/entries        (concat org-directory "/entries")
     org-agenda-files        (list org-directory user-org/entries)
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
        "* %?\n  %u\n  %a\n %i")
       ("t" "Task" entry (function user-org/find-and-hide-log)
        "* TODO %?\n  %u\n  %a\n %i")
       ("n" "Note" entry (function user-org/find-and-hide-log)
        "* %?\n  %u\n  %a\n %i")))))



(provide 'init-org-mode)
