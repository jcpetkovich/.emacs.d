;; init-org-mode.el - Setup emacs for editing org files.

(req-package org
  :require evil
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb))

  :config
  (progn
    (add-hook 'remember-mode-hook 'org-remember-apply-template)

    (bind-keys
     ("C-c c" . org-capture)
     ("C-c l" . org-store-link))

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

    (add-to-list 'org-modules 'org-timer)
    (setq-default
     org-hide-leading-stars  t
     org-odd-levels-only     t
     org-agenda-files        `(,(expand-file-name "~/mobileorg"))
     org-archive-location    "~/org/archive.org::* Finished Tasks"
     org-mobile-directory    "~/mobileorg/webdav"
     org-directory           "~/mobileorg"

     remember-annotation-functions '(org-remember-annotation)
     remember-handler-functions '(org-remember-handler)
     my-notes-file "~/mobileorg/whiteboard.org"

     org-capture-templates
     '(("g" "General Inbox" entry (file+headline my-notes-file "Inbox")
        "* TODO %?\n  %u\n  %a\n %i")
       ("p" "Personal Task" entry (file+headline my-notes-file "Inbox")
        "* TODO %? :PERSONAL:\n  %u\n  %a\n %i")
       ("w" "Work Task" entry (file+headline my-notes-file "Inbox")
        "* TODO %? :BENCHMARKING: \n  %u\n  %a\n %i")
       ("n" "Note" entry (file+headline my-notes-file "Inbox")
        "* %? :NOTES:\n  %u\n  %a\n %i")
       ("r" "Project Note" entry (file+headline my-notes-file "Inbox")
        "* %? :PROJECTNOTE:\n  %u\n  %a\n %i")))))

(provide 'init-org-mode)
