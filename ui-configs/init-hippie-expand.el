
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol
                                         try-expand-whole-kill
                                         try-expand-line))

(defun hippie-expand-lines ()
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-expand-list
                                            try-expand-list-all-buffers
                                            try-expand-line
                                            try-expand-line-all-buffers)))
    (hippie-expand nil)))

(defadvice he-substitute-string (after he-paredit-fix activate)
  "remove extra paren when expanding line in paredit"
  (if (and paredit-mode (equal (substring str -1) ")"))
      (progn (backward-delete-char 1) (forward-char))))

(provide 'init-hippie-expand)
