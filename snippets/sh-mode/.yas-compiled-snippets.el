;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
                     '(("srcl" "function source_local() {\n    local file=\\$1\n    local DIR=\n    local SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\n    while [ -h \"$SOURCE\" ]; do \n        DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n        SOURCE=\"$(readlink \"$SOURCE\")\"\n        [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \n    done\n    DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n    source \"$\\{DIR\\}/$\\{file\\}\"\n}" "srcl" nil nil nil nil nil nil)
                       ("scrd" "SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\nwhile [ -h \"$SOURCE\" ]; do \n  DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n  SOURCE=\"$(readlink \"$SOURCE\")\"\n  [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \ndone\nDIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"" "scrd" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Tue Sep  1 10:57:45 2015
