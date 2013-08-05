;;; Compiled snippets and support files for `ess-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ess-mode
                     '(("srcl" "source_local <- function(fname){\n    argv <- commandArgs(trailingOnly = FALSE)\n    base_dir <- dirname(substring(argv[grep(\"--file=\", argv)], 8))\n    source(paste(base_dir, fname, sep=\"/\"))\n}" "srcl" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug  4 13:54:47 2013
