;;; packages.el --- keybindings Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar keybindings-packages
  '()
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar keybindings-excluded-packages '()
  "List of packages to exclude.")

(defun keybindings/init-my-package ()
  "Initialize my package"
  )
