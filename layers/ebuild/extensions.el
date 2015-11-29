;;; extensions.el --- ebuild Layer extensions File for Spacemacs
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

(defvar ebuild-pre-extensions
  '(
    ;; pre extension ebuilds go here
    )
  "List of all extensions to load before the packages.")

(defvar ebuild-post-extensions
  '(
    ;; post extension ebuilds go here
    sh-script
    conf-mode
    )
  "List of all extensions to load after the packages.")

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

;; For each extension, define a function ebuild/init-<extension-ebuild>
;;
;; (defun ebuild/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
