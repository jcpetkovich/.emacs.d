;;; packages.el --- irc Layer packages File for Spacemacs
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

(defvar irc-packages
  '(
    rcirc
    rcirc-notify
    rcirc-color
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar irc-excluded-packages '()
  "List of packages to exclude.")

(defun irc/init-rcirc ()
  (use-package rcirc
    :config
    (progn
      (require 's)
      (if (or (file-exists-p "~/.authinfo.gpg")
              (file-exists-p "~/.authinfo"))
          (progn
            (setq-default
             irc-user-name (plist-get (car (auth-source-search :port '("nickserv"))) :user)
             irc-simple-pass (funcall (plist-get (car (auth-source-search :port '("pass"))) :secret))
             rcirc-fill-column 'frame-width

             rcirc-server-alist
             `(("irc.mozilla.org"
                :channels ("#rust")
                :nick ,irc-user-name)
               ("eyolfson.ca"
                :nick "jcp"
                :port 6697
                :encryption tls
                :password ,irc-simple-pass)
               ("localhost"))

             ;; Configure plugins
             rcirc-notify-timeout 0
             rcirc-notify-check-frame t)

            ;; Configure
            rcirc-buffer-maximum-lines 2048)
        (message "Warning: no ~/.authinfo type file found"))

      (defadvice rcirc (before rcirc-read-from-authinfo activate)
        "Allow rcirc to read authinfo from ~/.authinfo.gpg via the auth-source API.
This doesn't support the chanserv auth method"
        (unless arg
          (dolist (p (auth-source-search :port '("nickserv" "bitlbee" "quakenet")
                                         :require '(:port :user)))
            (let ((secret (plist-get p :secret))
                  (method (intern (plist-get p :port))))
              (add-to-list 'rcirc-authinfo
                           (list (plist-get p :host)
                                 method
                                 (plist-get p :user)
                                 (if (functionp secret)
                                     (funcall secret)
                                   secret)))))))

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

      (require 'rcirc-notify)
      (rcirc-notify-add-hooks)
      (add-to-list 'evil-insert-state-modes 'rcirc-mode))))


(defun irc/init-rcirc-notify ()
  (use-package rcirc-notify
    :defer t))

(defun irc/init-rcirc-color ()
  (use-package rcirc-color
    :defer t
    :config
    (progn
      (set-default rcirc-color-is-deterministic t))))
