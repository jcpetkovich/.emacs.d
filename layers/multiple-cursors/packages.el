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

(setq multiple-cursors-packages
  '(
    multiple-cursors
    expand-region
    )
  )

(setq multiple-cursors-excluded-packages
  '(
    evil-escape
    )
  )

;; For each package, define a function multiple-cursors/init-<package-multiple-cursors>
(defun multiple-cursors/init-multiple-cursors ()
  "Initialize multiple cursors"
  (use-package mc-mark-more
    :commands (mc/region-strings
               mc/mmlte--down
               mc/mmlte--up
               mc/mmlte--left
               mc/mmlte--right)
    :config
    (require 'multiple-cursors))

  (use-package multiple-cursors
    :defer t
    :config
    (progn
      (require 'mc-mark-more)
      (bind-keys :map mc/keymap
           ("M-y" . yank-pop))
      (multiple-cursors/enable-compat))))

(defun multiple-cursors/post-init-multiple-cursors ()
  (use-package multiple-cursors
    :defer t
    :init
    (bind-keys
     ("M-m" . multiple-cursors/expand-or-mark-next-symbol)
     ("M-M" . multiple-cursors/expand-or-mark-next-word)
     ("M-'" . mc/mark-all-dwim)
     ("C-S-n" . mc/mmlte--down)
     ("C-S-p" . mc/mmlte--up)
     ("C-S-f" . mc/mmlte--right)
     ("C-S-b" . mc/mmlte--left))))


(defun multiple-cursors/post-init-expand-region ()
  (use-package expand-region
    :commands (er/mark-word er/mark-symbol)))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
