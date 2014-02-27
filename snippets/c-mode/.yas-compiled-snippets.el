;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("printf" "printf (\"${1:%s}\"${1:$(if (string-match \"%\" yas-text) \",\" \"\\);\")}$2${1:$(if (string-match \"%\" yas-text) \"\\);\" \"\")}" "printf" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Feb 27 10:15:56 2014
