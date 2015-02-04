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

(defun personal/kill-region-or-backward-word ()
  "If the `region-active-p' returns true, kill the current
region. If `rectangle-mark-mode' is active, kill the current
rectangle, otherwise, kill the previous word."
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-region)
    (backward-kill-word 1)))

(defun personal/save-region-or-current-line (arg)
  "If the `region-active-p' returns true, save the current
region. If `rectangle-mark-mode' is active, save the current
rectangle, otherwise, save the current line."
  (interactive "P")
  (if (region-active-p)
      (call-interactively 'kill-ring-save)
    (copy-line arg)))

(defun personal/force-revert ()
  "Force the buffer to reflect the associated file on disk."
  (interactive)
  (revert-buffer t t))

(defun personal/xor (&rest args)
  "Truthy xor"
  (let ((true-count 0))
    (--each args
      (when it (incf true-count)))
    (equalp 1 true-count)))

(defalias 'move-cursor-next-pane 'personal/move-cursor-next-pane)
(defun personal/move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defalias 'move-cursor-previous-pane 'personal/move-cursor-previous-pane)
(defun personal/move-cursor-previous-pane ()
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

(defun personal/evil-visual-or-normal-p ()
  "True if evil mode is enabled, and we are in normal or visual mode."
  (and (bound-and-true-p evil-mode)
       (not (memq evil-state '(insert emacs)))))

(defun personal/untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun personal/indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun personal/cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (personal/untabify-buffer)
  (delete-trailing-whitespace)
  (personal/indent-buffer))

(defun personal/new-line-dwim ()
  (interactive)
  (let ((break-open-pair (or (and (looking-back "{" 1) (looking-at "}"))
                             (and (looking-back ">" 1) (looking-at "<"))
                             (and (looking-back "(" 1) (looking-at ")"))
                             (and (looking-back "\\[" 1) (looking-at "\\]")))))
    (newline)
    (when break-open-pair
      (save-excursion
        (newline)
        (indent-for-tab-command)))
    (indent-for-tab-command)))

(defun personal/eval-and-replace-sexp ()
  (interactive)
  (save-excursion
    (backward-up-list)
    (forward-sexp)
    (eval-and-replace)))

(defun personal/transpose-params ()
  "Presumes that params are in the form (p, p, p) or {p, p, p} or [p, p, p]"
  (interactive)
  (let* ((end-of-first (cond
                        ((looking-at ", ") (point))
                        ((and (looking-back ",") (looking-at " ")) (- (point) 1))
                        ((looking-back ", ") (- (point) 2))
                        (t (error "Place point between params to transpose."))))
         (start-of-first (save-excursion
                           (goto-char end-of-first)
                           (personal/move-backward-out-of-param)
                           (point)))
         (start-of-last (+ end-of-first 2))
         (end-of-last (save-excursion
                        (goto-char start-of-last)
                        (personal/move-forward-out-of-param)
                        (point))))
    (transpose-regions start-of-first end-of-first start-of-last end-of-last)))


(defun personal/current-quotes-char ()
  (nth 3 (syntax-ppss)))

(defalias 'personal/point-is-in-string-p 'personal/current-quotes-char)

(defun personal/move-forward-out-of-param ()
  (while (not (looking-at ")\\|, \\| ?}\\| ?\\]"))
    (cond
     ((personal/point-is-in-string-p) (move-point-forward-out-of-string))
     ((looking-at "(\\|{\\|\\[") (forward-list))
     (t (forward-char)))))

(defun personal/move-backward-out-of-param ()
  (while (not (looking-back "(\\|, \\|{ ?\\|\\[ ?"))
    (cond
     ((personal/point-is-in-string-p) (move-point-backward-out-of-string))
     ((looking-back ")\\|}\\|\\]") (backward-list))
     (t (backward-char)))))

(provide 'user-utils)
