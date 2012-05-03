(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(add-hook 'org-mode-hook 'auto-complete-mode)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)

(setf my-notes-file "~/org/whiteboard.org")

(setq org-capture-templates
      '(("t" "Task" entry (file+headline "" "Tasks")
         "* TODO %?\n  %u\n  %a\n")
        ("p" "Personal Task" entry (file+headline my-notes-file "Todo Items")
         "* TODO %?\n  %u\n  %a\n %i")
        ("w" "Work Task" entry (file+headline my-notes-file "Work")
         "* TODO %?\n  %u\n  %a\n %i")
        ("g" "Goal" entry (file+headline my-notes-file "Goals")
         "* %?\n  %u\n  %a\n %i")
        ("n" "Note" entry (file+headline my-notes-file "Ideas/Tasks With No Deadlines")
         "* %?\n  %u\n  %a\n %i")))
