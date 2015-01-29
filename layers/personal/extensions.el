;;; extensions.el --- personal Layer extensions File for Spacemacs
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

(defvar personal-pre-extensions
  '(
    )
  "List of all extensions to load before the packages.")

(defvar personal-post-extensions
  '(
    ;; personals go here
    simple
    mu4e
    rcirc
    )
  "List of all extensions to load after the packages.")

(defun personal/init-simple ()
  (use-package simple
    :config (setq-default shell-file-name (executable-find "bash"))))

