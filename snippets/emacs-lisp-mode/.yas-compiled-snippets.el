;;; Compiled snippets and support files for `emacs-lisp-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'emacs-lisp-mode
                     '(("auto" ";;;###autoload" "autoload" nil nil nil nil nil nil)
                       ("ends" ";;; `(buffer-file-name-body)`.el ends here$0" "ends" nil nil nil nil nil nil)
                       ("head" ";; =============================================================\n;; $1\n;; =============================================================\n$0" "comment header" nil nil nil nil nil nil)
                       ("pro" "(provide '`(buffer-file-name-body)`)$0" "provide" nil nil nil nil nil nil)
                       ("req" "(require '$0)" "req" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Tue Jan  6 14:58:43 2015
