;;; packages.el --- email-config Layer packages File for Spacemacs
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

(setq email-config-packages
  '(
    ;; package names go here
    (mu4e :skip-install t)
    )
  )

(setq email-config-excluded-packages '())

(defun email-config/post-init-mu4e ()
  (setq gnutls-min-prime-bits 2048)

  (setq-default send-mail-function 'smtpmail-send-it
                message-send-mail-function 'smtpmail-send-it
                smtpmail-starttls-credentials
                '(("smtp.gmail.com" 587 nil nil))
                smtpmail-auth-credentials
                (expand-file-name "~/.authinfo.gpg")
                smtpmail-default-smtp-server "smtp.gmail.com"
                smtpmail-smtp-server "smtp.gmail.com"
                smtpmail-smtp-service 587
                smtpmail-debug-info t)

  (use-package mu4e
    :commands (mu4e mu4e-update-index)
    :config
    (progn

      (evilified-state-evilify-map mu4e-main-mode-map :mode mu4e-main-mode)
      (evilified-state-evilify mu4e-main-mode mu4e-main-mode-map)

      (bind-key "C-w C-o" 'delete-other-windows mu4e-main-mode-map)
      (setq-default mu4e-html2text-command "html2text -nobs -width 1000"
                    mu4e-view-show-images t
                    mu4e-confirm-quit nil
                    mu4e-maildir "~/mail"

                    ;; Sync program
                    mu4e-get-mail-command "offlineimap"

                    ;; Mail address
                    mu4e-user-mail-address-list '("jcpetkovich@gmail.com"
                                                  "me@jcpetkovich.com"
                                                  "j2petkov@uwaterloo.ca"
                                                  "jcpetkovich@acerta.ca")

                    ;; smtp configs
                    smtpmail-queue-mail  nil  ;; start in non-queuing mode
                    send-mail-function 'smtpmail-send-it
                    message-send-mail-function 'smtpmail-send-it
                    smtpmail-debug-info t
                    smtpmail-starttls-credentials
                    '(("smtp.gmail.com" 587 nil nil))
                    smtpmail-auth-credentials
                    (expand-file-name "~/.authinfo.gpg")
                    smtpmail-default-smtp-server "smtp.gmail.com"
                    smtpmail-smtp-server "smtp.gmail.com"
                    smtpmail-smtp-service 587

                    )

      (setq mu4e-contexts
            `( ,(make-mu4e-context
                 :name "Personal"
                 :enter-func (lambda () (mu4e-message "Switch to the Personal context"))
                 ;; leave-func not defined
                 :match-func (lambda (msg)
                               (when msg
                                 (or
                                  (mu4e-message-contact-field-matches msg :to "j2petkov@uwaterloo.ca")
                                  (mu4e-message-contact-field-matches msg :to "me@jcpetkovich.com")
                                  (mu4e-message-contact-field-matches msg :to "jcpetkovich@gmail.com"))))
                 :vars '(
                         ;; smtp account configs
                         ( smtpmail-queue-dir . "~/mail/personal/queue/cur/" )

                         ;; Special folders
                         ( mu4e-sent-folder . "/personal/bak.sent" )
                         ( mu4e-drafts-folder . "/personal/bak.drafts" )
                         ( mu4e-trash-folder . "/personal/bak.trash" )

                         ( mu4e-reply-to-address . "jcpetkovich@gmail.com" )
                         ( user-mail-address	     . "jcpetkovich@gmail.com"  )
                         ( user-full-name	    . "Jean-Christophe Petkovich" )

                         ;; include in message with C-c C-w
                         ( mu4e-compose-signature . "Jean-Christophe Petkovich" )
                         ( message-signature . "Jean-Christophe Petkovich" )

                         ))
               ,(make-mu4e-context
                 :name "Work"
                 :enter-func (lambda () (mu4e-message "Switch to the Work context"))
                 ;; leave-fun not defined
                 :match-func (lambda (msg)
                               (when msg
                                 (mu4e-message-contact-field-matches msg :to "jcpetkovich@acerta.ca")))
                 :vars '(

                         ;; smtp account configs
                         ( smtpmail-queue-dir . "~/mail/work/queue/cur/" )

                         ;; Special folders
                         ( mu4e-sent-folder . "/work/[Gmail].Sent Mail" )
                         ( mu4e-drafts-folder . "/work/[Gmail].Drafts" )
                         ( mu4e-trash-folder . "/work/[Gmail].Trash" )

                         ( mu4e-reply-to-address . "jcpetkovich@acerta.ca" )
                         ( user-mail-address	     . "jcpetkovich@acerta.ca"  )
                         ( user-full-name	    . "Jean-Christophe Petkovich" )

                         ;; include in message with C-c C-w
                         ( mu4e-compose-signature . "Jean-Christophe Petkovich" )
                         ( message-signature . "Jean-Christophe Petkovich" )

                         ))))



      (when (fboundp 'imagemagick-register-types)
        (imagemagick-register-types))

      (defun email-config/use-flyspell ()
        (flyspell-mode 1))

      (add-hook 'mu4e-compose-mode-hook 'email-config/use-flyspell)

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
        (kbd "c") 'visual-line-mode
        (kbd "|") 'mu4e-view-pipe
        (kbd "s") 'mu4e-view-save-attachment)

      (--each '(normal insert visual operator)
        (evil-declare-key it mu4e-compose-mode-map
          (kbd "C-c C-s") 'message-dont-send))))

)

;; For each package, define a function email-config/init-<package-name>
;;
;; (defun email-config/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
