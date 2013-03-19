
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

