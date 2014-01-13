
;;; ========================================
;;; My defuns
;;; ========================================
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

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

(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun shrink-whitespace ()
  "Remove white spaces around cursor to just one or none.
If current line contains non-white space chars, then shrink any
whitespace char surrounding cursor to just one space.  If current
line does not contain non-white space chars, then remove blank
lines to just one."
  (interactive)
  (let (cursor-point
        line-has-meat-p  ; current line contains non-white space chars
        spaceTabNeighbor-p
        whitespace-begin whitespace-end
        space-or-tab-begin space-or-tab-end
        line-begin-pos line-end-pos)
    (save-excursion
      ;; todo: might consider whitespace as defined by syntax table,
      ;; and also consider whitespace chars in unicode if syntax table
      ;; doesn't already considered it.
      (setq cursor-point (point))
      (setq spaceTabNeighbor-p
            (if (or (looking-at " \\|\t") (looking-back " \\|\t"))
                t
              nil))
      (move-beginning-of-line 1)
      (setq line-begin-pos (point))
      (move-end-of-line 1)
      (setq line-end-pos (point))
      (setq line-has-meat-p
            (if (< 0 (count-matches "[[:graph:]]" line-begin-pos line-end-pos))
                t
              nil))
      (goto-char cursor-point)
      (skip-chars-backward "\t ")
      (setq space-or-tab-begin (point))
      (skip-chars-backward "\t \n")
      (setq whitespace-begin (point))
      (goto-char cursor-point)
      (skip-chars-forward "\t ")
      (setq space-or-tab-end (point))
      (skip-chars-forward "\t \n")
      (setq whitespace-end (point)))
    (if line-has-meat-p
        (progn
          (when spaceTabNeighbor-p
            (delete-region space-or-tab-begin space-or-tab-end)
            (insert " ")))

      (progn
        (delete-blank-lines)))))

(defun line-has-meat-p ()
  "Returns `t' if line has any characters, `nil' otherwise."
  (interactive)
  (move-beginning-of-line 1)
  (let ((line-begin-pos (point)))
    (move-end-of-line 1)
    (setq line-end-pos (point))
    (if (< 0 (count-matches "[[:graph:]]" line-begin-pos line-end-pos))
        t
      nil)))

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


(provide 'my-defuns)
