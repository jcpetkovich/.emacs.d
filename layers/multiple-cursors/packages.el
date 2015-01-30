;;; packages.el --- multiple-cursors Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>>
;; URL: https://github.com/jcpetkovich/spacemacs.multiple-cursors
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar multiple-cursors-packages
  '(
    multiple-cursors
    expand-region
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar multiple-cursors-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function multiple-cursors/init-<package-multiple-cursors>
(defun multiple-cursors/init-multiple-cursors ()
  "Initialize multiple cursors"
  (use-package multiple-cursors
    :init
    (progn
      (require 'mc-mark-more)
      (multiple-cursors/enable-compat))))

(defun multiple-cursors/init-expand-region ()
  (use-package expand-region
    :commands (er/mark-word er/mark-symbol)))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
