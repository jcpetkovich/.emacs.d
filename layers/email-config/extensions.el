;;; extensions.el --- email-config Layer extensions File for Spacemacs
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

(defvar email-config-pre-extensions
  '(
    ;; pre extension email-configs go here
    )
  "List of all extensions to load before the packages.")

(defvar email-config-post-extensions
  '(
    ;; post extension email-configs go here
    mu4e
    )
  "List of all extensions to load after the packages.")


(defun email-config/init-mu4e ()
  (setq gnutls-min-prime-bits 2048)

  (setq-default send-mail-function 'smtpmail-send-it
                message-send-mail-function 'smtpmail-send-it
                smtpmail-starttls-credentials
                '(("smtp.gmail.com" 587 nil nil))
                smtpmail-auth-credentials
                (expand-file-name "~/.authinfo")
                smtpmail-default-smtp-server "smtp.gmail.com"
                smtpmail-smtp-server "smtp.gmail.com"
                smtpmail-smtp-service 587
                smtpmail-debug-info t)

  (use-package mu4e
    :commands (mu4e mu4e-update-index)
    :config
    (progn
      (evilify mu4e-main-mode mu4e-main-mode-map)
      (setq-default mu4e-html2text-command "html2text -nobs -width 1000"
                    mu4e-view-show-images t
                    mu4e-confirm-quit nil
                    mu4e-maildir "~/Maildir"
                    smtpmail-queue-mail  nil  ;; start in non-queuing mode
                    smtpmail-queue-dir   "~/Maildir/queue/cur"

                    ;; Special folders
                    mu4e-sent-folder   "/bak.sent"
                    mu4e-drafts-folder "/bak.drafts"
                    mu4e-trash-folder  "/bak.trash"

                    ;; Mail address
                    mu4e-user-mail-address-list
                    '("jcpetkovich@gmail.com" "me@jcpetkovich.com" "j2petkov@uwaterloo.ca")

                    ;; Sync program
                    mu4e-get-mail-command "offlineimap"

                    mu4e-reply-to-address "jcpetkovich@gmail.com"
                    user-mail-address "jcpetkovich@gmail.com"
                    user-full-name  "Jean-Christophe Petkovich"

                    ;; include in message with C-c C-w
                    mu4e-compose-signature
                    "Jean-Christophe Petkovich"
                    message-signature
                    "Jean-Christophe Petkovich")

      (when (fboundp 'imagemagick-register-types)
        (imagemagick-register-types))

      (defun email-config/use-flyspell ()
        (flyspell-mode 1))

      (add-hook 'mu4e-compose-mode-hook 'email-config/use-flyspell)

      (-each '(mu4e-view-mode mu4e-headers-mode)
        (lambda (mode)
          (add-to-list 'evil-motion-state-modes mode)))

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