;;; Compiled snippets and support files for `ruby-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ruby-mode
                     '(("ase" "assert_equal ${1:expected}, ${2:actual}$0" "assert_equal" nil nil nil nil nil nil)
                       ("cla" "class `(s-upper-camel-case (buffer-file-name-body))`\n  $0\nend" "class" nil nil nil nil nil nil)
                       ("def" "def $1\n    $0\nend" "def" nil nil nil nil nil nil)
                       ("defs" "def self.$1($2)\n  $0\nend" "def.self" nil nil nil nil nil nil)
                       ("tt" "def test_$1\n  $0\nend\n" "tt" nil nil nil nil nil nil)
                       ("do" "do ${1:|$2|}\n  $0\nend" "do-block" nil nil nil nil nil nil)
                       ("tc" "require 'test/unit'\nrequire '$1'\n\nclass ${1:$(upper-camel-case yas/text)}TestCase < Test::Unit::TestCase\n\n  tt$0\n\nend" "testcase" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sat Nov 30 19:14:07 2013
