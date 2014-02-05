;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
                     '(("scrd" "SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\nwhile [ -h \"$SOURCE\" ]; do \n  DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n  SOURCE=\"$(readlink \"$SOURCE\")\"\n  [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \ndone\nDIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"" "scrd" nil nil nil nil nil nil)
                       ("srcl" "function source_local() {\n    local file=\\$1\n    local DIR=\n    local SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\n    while [ -h \"$SOURCE\" ]; do \n        DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n        SOURCE=\"$(readlink \"$SOURCE\")\"\n        [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \n    done\n    DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n    source \"$\\{DIR\\}/$\\{file\\}\"\n}" "srcl" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed Jan 22 14:22:05 2014
