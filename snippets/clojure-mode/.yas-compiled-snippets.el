;;; Compiled snippets and support files for `clojure-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'clojure-mode
                     '(("ns" "(ns `(snippet--clojure-namespace-from-buffer-file-name)`)$0" "namespace" nil nil nil nil nil nil)
                       ("tt" "(deftest $1\n  (is (= $0)))" "test" nil nil nil nil nil nil)
                       ("tc" "(ns `(snippet--clojure-namespace-from-buffer-file-name)`\n  (:use [`(snippet--clojure-namespace-under-test)`])\n  (:use [clojure.test]))\n\ntt$0" "testcase" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon May  4 13:32:54 2015
