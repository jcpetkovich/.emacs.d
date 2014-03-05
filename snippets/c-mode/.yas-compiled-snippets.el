;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("main" "int main(${1:int argc, char *argv[]})\n{\n$0\nreturn 0;\n}" "main" nil nil nil nil nil nil)
                       ("printf" "printf(\"${1:%s}\"${1:$(if (string-match \"%\" yas-text) \", \" \"\\);\")}$0${1:$(if (string-match \"%\" yas-text) \"\\);\" \"\")}" "printf" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed Mar  5 13:45:50 2014
