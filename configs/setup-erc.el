
(add-to-list 'load-path "~/.emacs.d/site-lisp/rcirc-color")
(require 'setup-package)
(require 'setup-evil)
(require 'auth-source)
(require 'setup-dash)
(require 'dash)

;; Get username from authinfo.gpg
(setq irc-user-name
      (plist-get (car (auth-source-search :port '("nickserv"))) :user))

(setq rcirc-fill-column 'frame-width)

;;; Trying this out, hopefully it's not too spammy
(setq rcirc-notify-timeout 0)

(setq rcirc-server-alist
      `(("irc.freenode.net"
         :channels ("#ruby"
                    "#python"
                    "#perl"
                    "#Node.js"
                    "#haskell"
                    "#clojure"
                    "#scheme"
                    "#lisp"
                    "#emacs")
         :nick ,irc-user-name
         )
        ("irc.mozilla.org"
         :channels ("#rust")
         :nick ,irc-user-name)
        ("localhost")))


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

;;; Start in insert mode
(eval-after-load "evil"
  '(add-to-list 'evil-insert-state-modes 'rcirc-mode))

(eval-after-load "rcirc"
  '(progn (require 'rcirc-color)
          (setq rcirc-notify-check-frame t)
          (rcirc-notify-add-hooks)
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
                                   channels)))))))


;; ;;; These might be potentially useful
;; (defun rcirc-target-buffer-visible (proc sender response target text)
;;   "Alternative for checking if a target buffer is visible"
;;   (-any? (lambda (buffer) (equal buffer (rcirc-target-buffer proc sender response target text)))
;;          (rcirc-visible-buffers)))

;; (defun rcirc-notify-privmsg (proc sender response target text)
;;   "Notify the current user when someone sends a private message
;; to them."
;;   (interactive)
;;   (when (and (string= response "PRIVMSG")
;;              (not (string= sender (rcirc-nick proc)))
;;              (not (rcirc-channel-p target))
;;              (not (rcirc-target-buffer-visible proc sender response target text))
;;              (rcirc-notify-allowed sender))
;;     (rcirc-notify-private sender text)))




(provide 'setup-erc)
