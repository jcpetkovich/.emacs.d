(require-package 'org '(20140331))
(require 'org)
(require 'setup-evil)

(setq org-hide-leading-stars  t)
(setq org-odd-levels-only     t)
(setq org-agenda-files        `(,(expand-file-name "~/mobileorg")))
(setq org-archive-location    "~/org/archive.org::* Finished Tasks")
(setq org-mobile-directory    "~/mobileorg/webdav")
(setq org-directory           "~/mobileorg")

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)

(setf my-notes-file "~/mobileorg/whiteboard.org")

(setq org-capture-templates
      '(("g" "General Inbox" entry (file+headline my-notes-file "Inbox")
         "* TODO %?\n  %u\n  %a\n %i")
        ("p" "Personal Task" entry (file+headline my-notes-file "Inbox")
         "* TODO %? :PERSONAL:\n  %u\n  %a\n %i")
        ("w" "Work Task" entry (file+headline my-notes-file "Inbox")
         "* TODO %? :BENCHMARKING: \n  %u\n  %a\n %i")
        ("n" "Note" entry (file+headline my-notes-file "Inbox")
         "* %? :NOTES:\n  %u\n  %a\n %i")
        ("r" "Project Note" entry (file+headline my-notes-file "Inbox")
         "* %? :PROJECTNOTE:\n  %u\n  %a\n %i")))


(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list 'org-modules 'org-timer)))

;; Hook for correcting behaviour in org mode
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "M-e") 'dabbrev-expand))) ; was org-move-paragraph

;;; Some evil things
(evil-declare-key 'normal org-mode-map
  (kbd "\C-c\/") 'org-sparse-tree)

(--each '(normal insert)
  (evil-declare-key it org-mode-map
    (kbd "C-M-l") 'org-metaright
    (kbd "C-M-h") 'org-metaleft
    (kbd "C-M-k") 'org-metaup
    (kbd "C-M-j") 'org-metadown
    (kbd "C-M-S-l") 'org-shiftmetaright
    (kbd "C-M-S-h") 'org-shiftmetaleft
    (kbd "C-M-S-k") 'org-shiftmetaup
    (kbd "C-M-S-j") 'org-shiftmetadown))

(provide 'setup-org-mode)
