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
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar multiple-cursors-excluded-packages '()
  "List of packages to exclude.")

(defvar multiple-cursors/evil-prev-state nil)
(defvar multiple-cursors/mark-was-active nil)

(defun multiple-cursors/evil-visual-or-normal-p ()
  "True if evil mode is enabled, and we are in normal or visual mode."
  (and (bound-and-true-p evil-mode)
       (not (memq evil-state '(insert emacs)))))

(defun multiple-cursors/switch-to-emacs-state ()
  (when (multiple-cursors/evil-visual-or-normal-p)

    (setq multiple-cursors/evil-prev-state evil-state)

    (when (region-active-p)
      (setq multiple-cursors/mark-was-active t))

    (let ((mark-before (mark))
          (point-before (point)))

      (evil-emacs-state 1)

      (when (or multiple-cursors/mark-was-active (region-active-p))
        (goto-char point-before)
        (set-mark mark-before)))))

(defun multiple-cursors/back-to-previous-state ()
  (when multiple-cursors/evil-prev-state
    (unwind-protect
        (case multiple-cursors/evil-prev-state
          ((normal visual) (evil-force-normal-state))
          (t (message "Don't know how to handle previous state: %S"
                      multiple-cursors/evil-prev-state)))
      (setq multiple-cursors/evil-prev-state nil)
      (setq multiple-cursors/mark-was-active nil))))

(defun multiple-cursors/rectangular-switch-state ()
  (if rectangular-region-mode
      (multiple-cursors/switch-to-emacs-state)
    (setq multiple-cursors/evil-prev-state nil)))

(defadvice mc/edit-lines (before change-point-by-1 disable)
  " When running edit-lines, point will return (position + 1) as
 a result of how evil deals with regions"
  (when (multiple-cursors/evil-visual-or-normal-p)
    (if (> (point) (mark))
        (goto-char (1- (point)))
      (push-mark (1- (mark))))))

(defun multiple-cursors/expand-or-mark-next-symbol ()
  (interactive)
  (if (not (region-active-p))
      (er/mark-symbol)
    (let ((current-symbol (thing-at-point 'symbol))
          (current-region (car (mc/region-strings))))
      (if (string-equal current-symbol current-region)
          (call-interactively #'mc/mark-next-symbol-like-this)
        (call-interactively #'mc/mark-next-like-this)))))

(defun multiple-cursors/expand-or-mark-next-word ()
  (interactive)
  (if (not (region-active-p))
      (er/mark-word)
    (call-interactively #'mc/mark-next-like-this)))


(defun multiple-cursors/enable-compat ()
  (add-hook 'multiple-cursors-mode-enabled-hook
            'multiple-cursors/switch-to-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook
            'multiple-cursors/back-to-previous-state)
  (add-hook 'rectangular-region-mode-hook 'multiple-cursors/rectangular-switch-state)

  (ad-enable-advice 'mc/edit-lines 'before 'change-point-by-1))

(defun multiple-cursors/disable-compat ()
  (remove-hook 'multiple-cursors-mode-enabled-hook
               'multiple-cursors/switch-to-emacs-state)
  (remove-hook 'multiple-cursors-mode-disabled-hook
               'multiple-cursors/back-to-previous-state)
  (remove-hook 'rectangular-region-mode-hook 'multiple-cursors/rectangular-switch-state)

  (ad-disable-advice 'mc/edit-lines 'before 'change-point-by-1))

;; For each package, define a function multiple-cursors/init-<package-multiple-cursors>
(defun multiple-cursors/init-multiple-cursors ()
  "Initialize multiple cursors"
  (use-package multiple-cursors
    :config
    (require 'mc-mark-more)
    (multiple-cursors/enable-compat)))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
