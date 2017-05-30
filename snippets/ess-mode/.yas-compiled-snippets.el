;;; Compiled snippets and support files for `ess-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ess-mode
                     '(("textangle" "theme(strip.text.y = element_text(angle = 0, hjust = 0, vjust = 0.5))" "textangle" nil nil nil "/home/jcp/.spacemacs.d/snippets/ess-mode/textangle.yasnippet" nil nil)
                       ("srcl" "source_local <- function(fname){\n    argv <- commandArgs(trailingOnly = FALSE)\n    base_dir <- dirname(substring(argv[grep(\"--file=\", argv)], 8))\n    if (length(base_dir)) { source(paste(base_dir, fname, sep=\"/\")) }\n    else {cat(\"ERROR: Could not source, running in a repl.\\n\")}\n}" "srcl" nil nil nil "/home/jcp/.spacemacs.d/snippets/ess-mode/source-local.yasnippet" nil nil)
                       ("f" "function(${1:args}) {$0}" "function" nil nil nil "/home/jcp/.spacemacs.d/snippets/ess-mode/function.yasnippet" nil nil)))


;;; Do not edit! File generated at Mon May  8 21:29:13 2017
