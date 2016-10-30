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

(setq irc-config-packages
	'(
    znc
		)
	)

(setq irc-config-excluded-packages '())

(setq-default erc-server-list
              '(("chat.freenode.net"
                 :port 6667
                 :nick "Kruppe")))

(setq erc-prompt-for-nickserv-password nil)
