;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
                     '(("srcl" "function source_local() {\n    local file=\\$1\n    local DIR=\n    local SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\n    while [ -h \"$SOURCE\" ]; do \n        DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n        SOURCE=\"$(readlink \"$SOURCE\")\"\n        [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \n    done\n    DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n    source \"$\\{DIR\\}/$\\{file\\}\"\n}" "srcl" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/source-local.yasnippet" nil nil)
                       ("scrd" "SOURCE=\"$\\{BASH_SOURCE[0]\\}\"\nwhile [ -h \"$SOURCE\" ]; do \n  DIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"\n  SOURCE=\"$(readlink \"$SOURCE\")\"\n  [[ $SOURCE != /* ]] && SOURCE=\"$DIR/$SOURCE\" \ndone\nDIR=\"$( cd -P \"$( dirname \"$SOURCE\" )\" && pwd )\"" "scrd" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/script-dir.yasnippet" nil nil)
                       ("lang" "# -*- mode: sh; sh-shell: $1 -*-" "lang" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/lang.yasnippet" nil nil)
                       ("head" "# $1\n# ▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂\n\n# ..................................................................... $2\n$0" "head" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/head.yasnippet" nil nil)
                       ("fspace" "find . -type f -name \"*.${1:extension}\" | while IFS= read -r file; do\n    ${2:echo \"file = $file\"}\ndone\n$0" "fspace" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/fspace.yasnippet" nil nil)
                       ("copy" "# jcpetkovich - 2016 (c) wtfpl" "copy" nil nil nil "/home/jcp/.spacemacs.d/snippets/sh-mode/copy.yasnippet" nil nil)))


;;; Do not edit! File generated at Wed Dec 13 16:35:20 2017
