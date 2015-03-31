;;; keybindings.el --- Journal Layer key-bindings File
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/jcpetkovich/.emacs.d
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; add journal funcs

(spacemacs/declare-prefix "," "journal")
(evil-leader/set-key
  ",," 'journal/open-todays-log
  ",a" 'org-agenda
  ",c" 'org-capture
  ",t" 'journal/quick-capture-todo)
