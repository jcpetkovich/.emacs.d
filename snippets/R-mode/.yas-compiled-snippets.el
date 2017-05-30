;;; Compiled snippets and support files for `R-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'R-mode
                     '(("srcl" "source_local <- function(fname){\n    argv <- commandArgs(trailingOnly = FALSE)\n    base_dir <- dirname(substring(argv[grep(\"--file=\", argv)], 8))\n    if (length(base_dir)) { source(paste(base_dir, fname, sep=\"/\")) }\n    else {cat(\"ERROR: Could not source, running in a repl.\\n\")}\n}" "srcl" nil nil nil "/home/jcp/.spacemacs.d/snippets/R-mode/source-local.yasnippet" nil nil)
                       ("f" "function(${1:args}) {$0}" "function" nil nil nil "/home/jcp/.spacemacs.d/snippets/R-mode/function.yasnippet" nil nil)))


;;; Do not edit! File generated at Mon May  8 21:29:13 2017
