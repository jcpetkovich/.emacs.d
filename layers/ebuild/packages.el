;;; packages.el --- ebuild Layer packages File for Spacemacs
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

(setq ebuild-packages
  '(
    ;; package ebuilds go here
    (conf-mode :location built-in)
    (sh-script :location built-in)
    )
  )

(setq ebuild-excluded-packages '())

(defun ebuild/post-init-sh-script ()
  (use-package sh-script
    :mode ("\\.\\(ebuild\\|eclass\\)$" . sh-mode)
    :config
    (add-hook 'sh-mode-hook (defun ebuild/set-bash ()
                              (when (string-match "\\.ebuild$" (or (buffer-file-name) ""))
                                (sh-set-shell "bash"))))))

(defun ebuild/init-conf-mode ()
  (use-package conf-mode
    :mode ("\\.\\(keywords\\|accept_keywords\\|use\\)$" . conf-mode)))

;; For each package, define a function ebuild/init-<package-ebuild>
;;
;; (defun ebuild/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
