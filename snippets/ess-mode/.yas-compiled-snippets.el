;;; Compiled snippets and support files for `ess-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ess-mode
                     '(("srcl" "source_local <- function(fname){\n    argv <- commandArgs(trailingOnly = FALSE)\n    base_dir <- dirname(substring(argv[grep(\"--file=\", argv)], 8))\n    if (length(base_dir)) { source(paste(base_dir, fname, sep=\"/\")) }\n    else {cat(\"ERROR: Could not source, running in a repl.\\n\")}\n}" "srcl" nil nil nil nil nil nil)
                       ("f" "function(${1:args}) {$0}" "function" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Tue Sep  1 10:57:44 2015
