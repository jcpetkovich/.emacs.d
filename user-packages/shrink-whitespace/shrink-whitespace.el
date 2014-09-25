;; shrink-whitespace.el - Tools for shrinking and growing whitespace intelligently

(defun shrink-whitespace ()
  "Remove whitespace around cursor to just one or none.
If current line contains non-white space chars, then shrink any
whitespace char surrounding cursor to just one space.  If current
line does not contain non-white space chars, then remove blank
lines to just one."
  (interactive)
  (cond ((shrink-whitespace/just-one-space-p)
         (delete-horizontal-space))
        ((and (shrink-whitespace/line-has-meat-p)
              (or
               (looking-at " \\|\t")
               (looking-back " \\|\t")))
         (just-one-space))
        (t
         (delete-blank-lines))))

(defun shrink-whitespace/xor (&rest args)
  (let ((true-count 0))
    (--each args
      (when it (incf true-count)))
    (equalp 1 true-count)))

(defun shrink-whitespace/just-one-space-p ()
  "Returns true if there is only one space nearby."
  (if (shrink-whitespace/xor
       (looking-at "^ ")
       (and (looking-at "\\( \\|\t\\)[^ \t]") (not (looking-back " \\|\t")))
       (and (looking-back "[^ \t]\\( \\|\t\\)") (not (looking-at " \\|\t"))))
      t
    nil))

(defun shrink-whitespace/line-has-meat-p ()
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

(defun shrink-whitespace/grow-whitespace-around ()
  "Counterpart to shrink-whitespace, grow whitespace in a
  smartish way."
  (interactive)
  (let ((content-above nil)
        (content-below nil))

    (save-excursion
      ;; move up a line and to the beginning
      (beginning-of-line 0)

      (when (shrink-whitespace/line-has-meat-p)
        (setq content-above t)))

    (save-excursion
      ;; move down a line and to the beginning
      (beginning-of-line 2)
      (when (shrink-whitespace/line-has-meat-p)
        (setq content-below t)))

    (save-excursion
      (if content-above
          (open-line-above)
        (if content-below
            (open-line-below))))
    (if (and (equal (line-beginning-position) (point))
             content-above)
        (forward-line))))

(defun shrink-whitespace/shrink-whitespace-around ()
  (interactive)
  (let ((content-above nil)
        (content-below nil))

    (save-excursion
      (beginning-of-line 0)
      (when (shrink-whitespace/line-has-meat-p)
        (setq content-above t)))

    (save-excursion
      (beginning-of-line 2)
      (when (shrink-whitespace/line-has-meat-p)
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

(defalias 'grow-whitespace-around 'shrink-whitespace/grow-whitespace-around)
(defalias 'shrink-whitespace-around 'shrink-whitespace/shrink-whitespace-around)

(provide 'shrink-whitespace)
;; shrink-whitespace.el ends here
