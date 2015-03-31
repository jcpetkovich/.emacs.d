;;; packages.el --- theme Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar theme-packages
  '(
    moe-theme
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar theme-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function theme/init-<package-theme>
;;
(defun theme/init-moe-theme ()
  (require 'moe-theme)
  )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
