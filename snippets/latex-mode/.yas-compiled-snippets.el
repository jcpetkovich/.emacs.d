;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("use" "\\usepackage${1:[]}{${2:package}}" "usepackage" nil nil nil "/home/jcp/.spacemacs.d/snippets/latex-mode/usepackage.yasnippet" nil nil)
                       ("table" "\\begin\\{table\\}\n  \\caption\\{\\label\\{tab:${1:label}\\}${2:caption}\\}\n  \\begin\\{center\\}\n\\begin\\{tabular\\}\\{${3:tablespec}\\}\n$0\n\\end\\{tabular\\}\n  \\end\\{center\\}\n\\end\\{table\\}" "tabular" nil nil nil "/home/jcp/.spacemacs.d/snippets/latex-mode/table.yasnippet" nil nil)
                       ("lst" "\\begin\\{lstlisting\\}[label=${1:listing}, language=${2:C}]\n$0\n\\end\\{lstlisting\\}" "lstlisting" nil nil nil "/home/jcp/.spacemacs.d/snippets/latex-mode/listing.yasnippet" nil nil)))


;;; Do not edit! File generated at Mon May  8 21:29:14 2017
