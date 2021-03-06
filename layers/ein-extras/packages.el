;;; packages.el --- ein-extras layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `ein-extras-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `ein-extras/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `ein-extras/pre-init-PACKAGE' and/or
;;   `ein-extras/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq ein-extras-packages '(ein jedi))

(defun ein-extras/open-current ()
  (interactive)
  (ein:notebook-open 8888 (file-relative-name
                           buffer-file-name
                           user-home-directory)))

(defun ein-extras/post-init-ein ()
  (use-package ein
    :bind (:map ein:notebook-multilang-mode-map
                ("M-k" . personal/move-cursor-previous-pane)
                ("M-j" . personal/move-cursor-next-pane))
    :config
    (progn
      (add-hook 'ein:notebook-multilang-mode-hook
                'smartparens-strict-mode)

      (setq ein:use-auto-complete t)
      (setq ein:complete-on-dot nil)
      (setq ein:completion-backend 'ein:use-company-backend)
      (setq ein:use-auto-complete-superpack nil)
      (setq ein:use-smartrep nil)

      ;; (setq-default ein:worksheet-enable-undo 'yes)
      )))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun ein-extras/init-jedi ()
;;     (setq-default ein:use-auto-complete t)
;;     (setq-default ein:complete-on-dot nil)))

;;; packages.el ends here
