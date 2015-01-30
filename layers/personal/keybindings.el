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
 ("M-1" . delete-other-windows)
 ("M-!" . delete-window)
 ("M-2" . split-window-vertically)
 ("M-@" . split-window-horizontally)
 ("M-j" . personal/move-cursor-next-pane)
 ("M-k" . personal/move-cursor-previous-pane))

(--each '(insert visual normal)
  (evil-declare-key it paredit-mode-map
    (kbd "C-w") 'personal/kill-region-or-backward-word))

(defun annoying ()
  (interactive)
  (message "Try something else"))

(bind-keys
 ("C-x C-f" . annoying)
 ("C-x C-b" . annoying)
 ("C-x b" . annoying)
 ("C-x C-s" . annoying)
 ([remap ido-find-file] . helm-find-files)
 ([remap ido-kill-buffer] . kill-buffer)
 ([remap ido-switch-buffer] . helm-C-x-b))

(evil-leader/set-key
  "am" 'emms-smart-browse
  "ase" 'esh)
