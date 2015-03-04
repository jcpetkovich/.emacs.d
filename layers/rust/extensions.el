;;; extensions.el --- rust Layer extensions File for Spacemacs
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

(defvar rust-pre-extensions
  '(
    ;; pre extension rusts go here
    )
  "List of all extensions to load before the packages.")

(defvar rust-post-extensions
  '(
    ;; post extension rusts go here
    conf-mode
    )
  "List of all extensions to load after the packages.")

(defun rust/init-conf-mode ()
  "Initialize my extension"
  (use-package conf-mode
    :defer t
    :mode ("\\.toml$" . conf-mode)))
