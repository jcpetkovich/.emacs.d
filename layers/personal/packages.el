;;; packages.el --- Personal Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar personal-packages
  '(
    evil
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar personal-excluded-packages '()
  "List of packages to exclude.")

(defun personal/init-evil ()
  "Initialize my package"
  (use-package evil
    :config
    (progn
      (setq-default evil-want-C-i-jump nil
                    evil-symbol-word-search t
                    evil-cross-lines t
                    evil-esc-delay 0))))
