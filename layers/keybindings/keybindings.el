;;; keybindings.el --- Spacemacs Layer key-bindings File
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/jcpetkovich/spacemacs.d
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; instantly display current keystrokes in mini buffer
(bind-keys
 ("M-m" . multiple-cursors/expand-or-mark-next-symbol)
 ("M-M" . multiple-cursors/expand-or-mark-next-word)
 ("M-'" . mc/mark-all-dwim)
 ("C-S-n" . mc/mmlte--down)
 ("C-S-p" . mc/mmlte--up)
 ("C-S-f" . mc/mmlte--right)
 ("C-S-b" . mc/mmlte--left))
