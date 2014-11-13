;;; Compiled snippets and support files for `python-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'python-mode
                     '(("def" "def ${1:name}($2):\n    $0" "def" nil nil nil nil nil nil)
                       ("pstderr" "print >> sys.stderr, \"$1\"" "pstderr" nil nil nil nil nil nil)
                       ("sub" "subprocess.${1:check_output}($2, shell=True)$0" "subprocess" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Nov 13 12:26:28 2014
