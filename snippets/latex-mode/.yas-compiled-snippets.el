;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("lst" "\\begin\\{lstlisting\\}[label=${1:listing}, language=${2:C}]\n$0\n\\end\\{lstlisting\\}" "lstlisting" nil nil nil nil nil nil)
                       ("table" "\\begin\\{table\\}\n  \\caption\\{\\label\\{tab:${1:label}\\}${2:caption}\\}\n  \\begin\\{center\\}\n\\begin\\{tabular\\}\\{${3:tablespec}\\}\n$0\n\\end\\{tabular\\}\n  \\end\\{center\\}\n\\end\\{table\\}" "tabular" nil nil nil nil nil nil)
                       ("use" "\\usepackage${1:[]}{${2:package}}" "usepackage" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Fri May 29 16:55:12 2015
