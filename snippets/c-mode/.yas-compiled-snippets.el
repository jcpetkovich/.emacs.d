;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("printf" "printf (\"${1:%s}\"${1:$(if (string-match \"%\" yas-text) \",\" \"\\);\")}$2${1:$(if (string-match \"%\" yas-text) \"\\);\" \"\")}" "printf" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed Jan 22 08:52:23 2014
