;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("begin" "\\begin\\{${1:environment}\\}\n$0\n\\end\\{$1\\}" "begin/end" nil nil nil nil nil nil)
                       ("lst" "\\begin\\{lstlisting\\}[label=${1:listing}, language=${2:C}]\n$0\n\\end\\{lstlisting\\}" "lstlisting" nil nil nil nil nil nil)
                       ("table" "\\begin\\{table\\}\n  \\caption\\{\\label\\{tab:${1:label}\\}${2:caption}\\}\n  \\begin\\{center\\}\n\\begin\\{tabular\\}\\{${3:tablespec}\\}\n$0\n\\end\\{tabular\\}\n  \\end\\{center\\}\n\\end\\{table\\}" "tabular" nil nil nil nil nil nil)
                       ("use" "\\usepackage${1:[]}{${2:package}}" "usepackage" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Tue Mar 18 12:42:22 2014
