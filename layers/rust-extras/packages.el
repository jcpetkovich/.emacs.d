;;; packages.el --- rust Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar rust-packages
  '(
    rust-mode
    ;; package rusts go here
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar rust-excluded-packages '()
  "List of packages to exclude.")

(defun rust/init-rust-mode ()
  "Initialize rust-mode"
  (use-package rust-mode
    :defer t))
