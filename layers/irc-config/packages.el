;;; packages.el --- irc-config Layer packages File for Spacemacs
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

(defvar irc-config-packages
  '(
    rcirc
    rcirc-notify
    rcirc-color
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar irc-config-excluded-packages '()
  "List of packages to exclude.")

(defun irc-config/init-rcirc ()
  (use-package rcirc
    :commands rcirc
    :defer t
    :init
    (progn
      (add-to-list 'evil-normal-state-modes 'rcirc-mode)
      (if (file-exists-p "~/.authinfo.gpg")

          (progn
            (require 'auth-source)
            (setq-default
             irc-user-name (plist-get (car (auth-source-search :port '("nickserv"))) :user)
             baconbunny-password (funcall (plist-get (car (auth-source-search :port "irc" :host "irc.baconbunny.com")) :secret))
             rcirc-fill-column 'frame-width

             rcirc-server-alist
             `(("localhost")
               ("eyolfson.ca"
                :port 6697
                :encryption tls
                :auth "jcp")
               ("irc.baconbunny.com"
                :nick "jcp"
                :channels ("#gentoo")
                :password ,baconbunny-password))

             ;; Configure plugins
             rcirc-notify-timeout 0
             rcirc-notify-check-frame t

             ;; Configure
             rcirc-buffer-maximum-lines 2048))
        (message "Warning: no ~/.authinfo type file found")))
    :config
    (progn
      (require 's)

      (defun-rcirc-command reconnect (arg)
        "Reconnect the server process."
        (interactive "i")
        (if (buffer-live-p rcirc-server-buffer)
            (with-current-buffer rcirc-server-buffer
              (let ((reconnect-buffer (current-buffer))
                    (server (or rcirc-server rcirc-default-server))
                    (port (if (boundp 'rcirc-port) rcirc-port rcirc-default-port))
                    (nick (or rcirc-nick rcirc-default-nick))
                    channels)
                (dolist (buf (buffer-list))
                  (with-current-buffer buf
                    (when (equal reconnect-buffer rcirc-server-buffer)
                      (remove-hook 'change-major-mode-hook
                                   'rcirc-change-major-mode-hook)
                      (let ((server-plist (cdr (assoc-string server rcirc-server-alist))))
                        (when server-plist
                          (setq channels (plist-get server-plist :channels))))
                      )))
                (if process (delete-process process))
                (rcirc-connect server port nick
                               nil
                               nil
                               channels)))))
      ;; This might be potentially useful
      (defun rcirc-target-buffer-visible (proc sender response target text)
        "Alternative for checking if a target buffer is visible"
        (-any? (lambda (buffer) (equal buffer (rcirc-target-buffer proc sender response target text)))
               (rcirc-visible-buffers)))

      ;; TODO: Use an rcirc markup function for otr cleanup instead
      (defun strip-otr-prefix (text)
        (s-replace "05" "" text))

      (defadvice rcirc-print (around rcirc-print-filter activate)
        (let* ((text (ad-get-arg 4))
               (new-text (strip-otr-prefix text)))
          (ad-set-arg 4 new-text)
          ad-do-it))

      ;; Show where t.co urls are pointing
      (defun t.co-resolve (url)
        "Resolve t.co URL by launching `curl --head' and parsing the result."
        (assert (string-match (concat "^" rcirc-url-regexp "$") url))
        (let* ((curl (shell-command-to-string (format "curl --silent --head %s" url)))
               (location (when (and (string-match "\\`HTTP/1\.1 301" curl)
                                    (string-match (concat "^Location: "
                                                          rcirc-url-regexp) curl))
                           (match-string 1 curl))))
          (or location url)))

      (defun t.co-url-replace (sender response)
        "Call `t.co-resolve' on every matching URL."
        (let ((re "http://t\\.co/[a-z0-9]+"))
          (while (re-search-forward re nil t)
            (replace-match (save-match-data (t.co-resolve (match-string 0)))))))

      (add-to-list 'rcirc-markup-text-functions
                   't.co-url-replace)

      (require 'rcirc-notify))))


(defun irc-config/init-rcirc-notify ()
  (use-package rcirc-notify
    :defer t
    :config (rcirc-notify-add-hooks)))

(defun irc-config/init-rcirc-color ()
  (use-package rcirc-color
    :defer t
    :config
    (setq-default rcirc-color-is-deterministic t)))
