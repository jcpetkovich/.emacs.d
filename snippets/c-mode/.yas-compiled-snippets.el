;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("printf" "printf(\"${1:%s}\"${1:$(if (string-match \"%\" yas-text) \", \" \"\\);\")}$0${1:$(if (string-match \"%\" yas-text) \"\\);\" \"\")}" "printf" nil nil nil "/home/jcp/.spacemacs.d/snippets/c-mode/printf" nil nil)
                       ("main" "int main(${1:int argc, char *argv[]})\n{\n$0\nreturn 0;\n}" "main" nil nil nil "/home/jcp/.spacemacs.d/snippets/c-mode/main.yasnippet" nil nil)
                       ("for" "for (${1:int i = 0}; ${2:i < NUM}; ${3:++i}) {\n$0\n}" "for" nil nil nil "/home/jcp/.spacemacs.d/snippets/c-mode/for.yasnippet" nil nil)))


;;; Do not edit! File generated at Wed Jul 26 13:54:08 2017
