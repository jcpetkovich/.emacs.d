;; shrink-whitespace.el - Tools for shrinking and growing whitespace intelligently

;; Toggle fullscreen mode
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(defun call-keyword-completion ()
  "Call the command that has keyboard shortcut M-TAB."
  (interactive)
  (call-interactively (key-binding (kbd "M-TAB"))))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun shrink-whitespace ()
  "Remove whitespace around cursor to just one or none.
If current line contains non-white space chars, then shrink any
whitespace char surrounding cursor to just one space.  If current
line does not contain non-white space chars, then remove blank
lines to just one."
  (interactive)
  (cond ((just-one-space-p)
         (delete-horizontal-space))
        ((and (line-has-meat-p)
              (or
               (looking-at " \\|\t")
               (looking-back " \\|\t")))
         (just-one-space))
        (t
         (delete-blank-lines))))

(defun xor (&rest args)
  (let ((true-count 0))
    (--each args
      (when it (incf true-count)))
    (equalp 1 true-count)))

(defun just-one-space-p ()
  "Returns true if there is only one space nearby."
  (if (xor
       (looking-at "^ ")
       (and (looking-at "\\( \\|\t\\)[^ \t]") (not (looking-back " \\|\t")))
       (and (looking-back "[^ \t]\\( \\|\t\\)") (not (looking-at " \\|\t"))))
      t
    nil))

(defun line-has-meat-p ()
  "Returns `t' if line has any characters, `nil' otherwise."
  (save-excursion
    (move-beginning-of-line 1)
    (let ((line-begin-pos (point))
          line-end-pos)
      (move-end-of-line 1)
      (setq line-end-pos (point))
      (if (< 0 (count-matches "[[:graph:]]" line-begin-pos line-end-pos))
          t
        nil))))

(defun grow-whitespace-around ()
  "Counterpart to shrink-whitespace, grow whitespace in a
  smartish way."
  (interactive)
  (let ((content-above nil)
        (content-below nil))

    (save-excursion
      ;; move up a line and to the beginning
      (beginning-of-line 0)

      (when (line-has-meat-p)
        (setq content-above t)))

    (save-excursion
      ;; move down a line and to the beginning
      (beginning-of-line 2)
      (when (line-has-meat-p)
        (setq content-below t)))

    (save-excursion
      (if content-above
          (open-line-above)
        (if content-below
            (open-line-below))))
    (if (and (equal (line-beginning-position) (point))
             content-above)
        (forward-line))))

(defun shrink-whitespace-around ()
  (interactive)
  (let ((content-above nil)
        (content-below nil))

    (save-excursion
      (beginning-of-line 0)
      (when (line-has-meat-p)
        (setq content-above t)))

    (save-excursion
      (beginning-of-line 2)
      (when (line-has-meat-p)
        (setq content-below t)))

    (save-excursion
      (if (not content-above)
          (progn
            (beginning-of-line 0)
            (kill-line))
        (if (not content-below)
            (progn
              (beginning-of-line 2)
              (kill-line)))))))

(eval-after-load "evil"
  '(progn
     (evil-define-motion next-line-with-meat (count)
       :type line

       (next-line)
       (while (not (line-has-meat-p))
         (next-line))
       (evil-insert-line (or count 1)))

     (evil-define-motion previous-line-with-meat (count)
       :type line

       (previous-line)
       (while (not (line-has-meat-p))
         (previous-line))
       (evil-append-line (or count 1)))))

(provide 'shrink-whitespace)
;; shrink-whitespace.el ends here
