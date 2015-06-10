;;; funcs.el --- rcirc Layer functions
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; add personal functions

(defun irc-config/rcirc-home (arg)
  (interactive "P")
  (let ((rcirc-server-alist rcirc-home-server-alist))
    (spacemacs/rcirc arg)))
