;; ============================================================= 
;; ALL MAIL RELATED OPTIONS IN HERE
;; ============================================================= 

;; ============================================================= 
;; Outgoing (this works if the authentication file exists)
;; ============================================================= 
(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

;; ============================================================= 
;; Gnus
;; ============================================================= 
(setq user-full-name "Jean-Christophe Petkovich")

(eval-after-load "gnus"
  '(progn
     (setq gnus-parameters '(("*nnimap+gmail*"
                              (gnus-article-sort-functions '(gnus-article-sort-by-date))))
           gnus-invalid-group-regexp "[:`'\"]\\|^$")

     (add-to-list 'gnus-secondary-select-methods 
                  '(nnimap "gmail"
                           (nnimap-address "imap.gmail.com")
                           (nnimap-server-port 993)
                           (nnimap-stream ssl)))))
