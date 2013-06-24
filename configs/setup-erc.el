(require 'setup-evil)
;;; Get username from authinfo.gpg
(setq irc-user-name 
             (plist-get (first (auth-source-search :port '("nickserv"))) :user))

(setq rcirc-fill-column 'frame-width)

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

(require 'rcirc-color)
(require 'rcirc-notify)

(provide 'setup-erc)
