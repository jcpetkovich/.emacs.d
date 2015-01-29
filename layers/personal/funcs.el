;;; packages.el --- Personal Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; add personal functions

(defun user-utils/kill-region-or-backward-word ()
  "If the `region-active-p' returns true, kill the current
region. If `rectangle-mark-mode' is active, kill the current
rectangle, otherwise, kill the previous word."
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-region)
    (backward-kill-word 1)))

(defun user-utils/save-region-or-current-line (arg)
  "If the `region-active-p' returns true, save the current
region. If `rectangle-mark-mode' is active, save the current
rectangle, otherwise, save the current line."
  (interactive "P")
  (if (region-active-p)
      (call-interactively 'kill-ring-save)
    (copy-line arg)))

(defun user-utils/force-revert ()
  "Force the buffer to reflect the associated file on disk."
  (interactive)
  (revert-buffer t t))

(defun user-utils/xor (&rest args)
  "Truthy xor"
  (let ((true-count 0))
    (--each args
      (when it (incf true-count)))
    (equalp 1 true-count)))

(defalias 'move-cursor-next-pane 'user-utils/move-cursor-next-pane)
(defun user-utils/move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defalias 'move-cursor-previous-pane 'user-utils/move-cursor-previous-pane)
(defun user-utils/move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(eval-after-load "evil"
  '(progn
     (evil-define-motion next-line-with-meat (count)
       :type line

       (next-line)
       (while (not (shrink-whitespace/line-has-meat-p))
         (next-line))
       (evil-insert-line (or count 1)))

     (evil-define-motion previous-line-with-meat (count)
       :type line

       (previous-line)
       (while (not (shrink-whitespace/line-has-meat-p))
         (previous-line))
       (evil-append-line (or count 1)))))

(defun user-utils/evil-visual-or-normal-p ()
  "True if evil mode is enabled, and we are in normal or visual mode."
  (and (bound-and-true-p evil-mode)
       (not (memq evil-state '(insert emacs)))))

(defun user-utils/untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun user-utils/indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun user-utils/cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (user-utils/untabify-buffer)
  (delete-trailing-whitespace)
  (user-utils/indent-buffer))

(provide 'user-utils)
