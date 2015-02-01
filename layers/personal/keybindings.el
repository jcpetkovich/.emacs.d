;;; keybindings.el --- Spacemacs Layer key-bindings File
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/jcpetkovich/.emacs.d
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(bind-keys
 ;; ("M-1" . delete-other-windows)
 ;; ("M-!" . delete-window)
 ;; ("M-2" . split-window-vertically)
 ;; ("M-@" . split-window-horizontally)
 ("M-j" . personal/move-cursor-next-pane)
 ("M-k" . personal/move-cursor-previous-pane)
 ("<M-return>" . personal/new-line-dwim)
 ("M-RET" . personal/new-line-dwim))

(--each '(insert visual normal)
  (evil-declare-key it paredit-mode-map
    (kbd "C-w") 'personal/kill-region-or-backward-word))

(evil-leader/set-key
  "am" 'emms-smart-browse
  "ase" 'esh)
