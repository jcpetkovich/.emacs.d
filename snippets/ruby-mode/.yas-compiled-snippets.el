;;; Compiled snippets and support files for `ruby-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ruby-mode
                     '(("tc" "require 'test/unit'\nrequire '$1'\n\nclass ${1:$(upper-camel-case yas/text)}TestCase < Test::Unit::TestCase\n\n  tt$0\n\nend" "testcase" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/testcase" nil nil)
                       ("do" "do ${1:|$2|}\n  $0\nend" "do-block" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/do-block" nil nil)
                       ("tt" "def test_$1\n  $0\nend\n" "tt" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/deftest" nil nil)
                       ("defs" "def self.$1($2)\n  $0\nend" "def.self" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/def.self" nil nil)
                       ("def" "def $1\n    $0\nend" "def" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/def" nil nil)
                       ("cla" "class `(s-upper-camel-case (buffer-file-name-body))`\n  $0\nend" "class" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/class" nil nil)
                       ("ase" "assert_equal ${1:expected}, ${2:actual}$0" "assert_equal" nil nil nil "/home/jcp/.spacemacs.d/snippets/ruby-mode/assert_equal" nil nil)))


;;; Do not edit! File generated at Mon May  8 21:29:14 2017
