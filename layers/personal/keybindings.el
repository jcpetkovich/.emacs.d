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
 ("M-j" . personal/move-cursor-next-pane)
 ("M-k" . personal/move-cursor-previous-pane)
 ("<M-return>" . personal/new-line-dwim)
 ("M-RET" . personal/new-line-dwim))

(bind-keys
 ("C-w" . personal/kill-region-or-backward-word)
 ("M-w" . personal/save-region-or-current-line))

(evil-leader/set-key
  "am" 'emms-smart-browse
  "ase" 'esh
  "." 'personal/eval-and-replace-sexp
  "RET" 'personal/eval-print-last-sexp
  "xta" 'personal/transpose-params
  "xts" 'transpose-sexps
  "xt." 'transpose-sentences
  "xtp" 'transpose-paragraphs)
