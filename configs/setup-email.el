;; =============================================================
;; ALL MAIL RELATED OPTIONS IN HERE
;; =============================================================

(require 'setup-evil)

;; =============================================================
;; More encryption!
;; =============================================================

(setq gnutls-min-prime-bits 2048)

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

;; =============================================================
;; mu4e
;; =============================================================

(add-hook 'mu4e-compose-mode-hook (lambda ()
                                    (flyspell-mode 1)))

(when (require 'mu4e nil :noerror)

  (-each '(mu4e-view-mode mu4e-headers-mode)
    (lambda (mode)
      (add-to-list 'evil-motion-state-modes mode)))

  (add-to-list 'evil-emacs-state-modes 'mu4e-main-mode)

  (--each '(motion normal insert visual operator)
    (evil-declare-key it mu4e-headers-mode-map
      (kbd "RET") 'mu4e-headers-view-message
      (kbd "/") 'mu4e-headers-search-narrow
      (kbd "b") 'mu4e-headers-search-bookmark
      (kbd "!") 'mu4e-headers-mark-for-read
      (kbd "?") 'mu4e-headers-mark-for-unread))

  (evil-declare-key 'motion mu4e-view-mode-map
    (kbd "o") 'mu4e-view-open-attachment
    (kbd "i") 'mu4e-view-go-to-url
    (kbd "c") 'longlines-mode
    (kbd "|") 'mu4e-view-pipe
    (kbd "s") 'mu4e-view-save-attachment)

  (--each '(normal insert visual operator)
    (evil-declare-key it mu4e-compose-mode-map
      (kbd "C-c C-s") 'message-dont-send))

  (define-key global-map (kbd "<f5>") 'mu4e-update-index)

  (setq mu4e-html2text-command "html2text -nobs -width 1000"
        mu4e-view-show-images t
        mu4e-confirm-quit nil)

  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (setq mu4e-maildir "~/Maildir")

  (setq smtpmail-queue-mail  nil  ;; start in non-queuing mode
        smtpmail-queue-dir   "~/Maildir/queue/cur")

  ;; Special folders
  (setq mu4e-sent-folder   "/bak.sent"
        mu4e-drafts-folder "/bak.drafts"
        mu4e-trash-folder  "/bak.trash")

  ;; the maildirs you use frequently; access them with 'j' ('jump')
  ;; (setq   mu4e-maildir-shortcuts
  ;;         '(("/archive"     . ?a)
  ;;           ("/inbox"       . ?i)
  ;;           ("/work"        . ?w)
  ;;           ("/sent"        . ?s)))

  (setq mu4e-user-mail-address-list
        '("jcpetkovich@gmail.com" "me@jcpetkovich.com" "j2petkov@uwaterloo.ca"))

  ;; when you want to use some external command for text->html
  ;; conversion, e.g. the 'html2text' program
  ;; (setq mu4e-html2text-command "html2text")

  ;; the headers to show in the headers list -- a pair of a field
  ;; and its width, with `nil' meaning 'unlimited'
  ;; (better only use that for the last field.
  ;; These are the defaults:
  (setq mu4e-headers-fields
        '( (:date          .  25)
           (:flags         .   6)
           (:from          .  22)
           (:subject       .  nil)))

  ;; program to get mail; alternatives are 'fetchmail', 'getmail'
  ;; isync or your own shellscript. called when 'U' is pressed in
  ;; main view.

  ;; If you get your mail without an explicit command,
  ;; use "true" for the command (this is the default)
  (setq mu4e-get-mail-command "offlineimap")

  ;; general emacs mail settings; used when composing e-mail
  ;; the non-mu4e-* stuff is inherited from emacs/message-mode
  (setq mu4e-reply-to-address "jcpetkovich@gmail.com"
        user-mail-address "jcpetkovich@gmail.com"
        user-full-name  "Jean-Christophe Petkovich")
  ;; include in message with C-c C-w
  (setq mu4e-compose-signature
        "Jean-Christophe Petkovich")
  (setq message-signature
        "Jean-Christophe Petkovich"))

(provide 'setup-email)
