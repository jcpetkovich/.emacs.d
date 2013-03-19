
(require 'org)
(setq org-agenda-files (quote ("/home/jcp/mobileorg")))
(setq org-archive-location "~/org/archive.org::* Finished Tasks")
(setq org-mobile-directory "~/mobileorg/webdav")
(setq org-directory "~/mobileorg")

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)

(setf my-notes-file "~/mobileorg/whiteboard.org")

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
         "* %?\n  %u\n  %a\n %i")
        ("r" "Project Note" entry (file+headline my-notes-file "Project Notes")
         "* %?\n  %u\n  %a\n %i")))


(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list 'org-modules 'org-timer)))

(eval-after-load "auto-complete"
  '(add-hook 'org-mode-hook 'auto-complete-mode))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal org-mode-map
                       (kbd "\C-c\/") 'org-sparse-tree)

     (mapcar (lambda (evil-state)
               (evil-declare-key evil-state org-mode-map
                                 (kbd "C-M-l") 'org-metaright
                                 (kbd "C-M-h") 'org-metaleft
                                 (kbd "C-M-k") 'org-metaup
                                 (kbd "C-M-j") 'org-metadown
                                 (kbd "C-M-S-l") 'org-shiftmetaright
                                 (kbd "C-M-S-h") 'org-shiftmetaleft
                                 (kbd "C-M-S-k") 'org-shiftmetaup
                                 (kbd "C-M-S-j") 'org-shiftmetadown))
             '(normal insert))))

(provide 'setup-org-mode)