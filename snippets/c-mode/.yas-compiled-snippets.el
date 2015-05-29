;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("for" "for (${1:int i = 0}; ${2:i < NUM}; ${3:++i}) {\n$0\n}" "for" nil nil nil nil nil nil)
                       ("main" "int main(${1:int argc, char *argv[]})\n{\n$0\nreturn 0;\n}" "main" nil nil nil nil nil nil)
                       ("printf" "printf(\"${1:%s}\"${1:$(if (string-match \"%\" yas-text) \", \" \"\\);\")}$0${1:$(if (string-match \"%\" yas-text) \"\\);\" \"\")}" "printf" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Fri May 29 16:55:12 2015
