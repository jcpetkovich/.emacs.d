;;; Compiled snippets and support files for `snippets'
;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("tc" "(ns `(snippet--clojure-namespace-from-buffer-file-name)`\n  (:use [`(snippet--clojure-namespace-under-test)`])\n  (:use [clojure.test]))\n\ntt$0" "testcase" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/testcase" nil nil)
                       ("tt" "(deftest $1\n  (is (= $0)))" "test" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/test" nil nil)
                       ("ns" "(ns `(snippet--clojure-namespace-from-buffer-file-name)`)$0" "namespace" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/namespace" nil nil)
                       ("dst" ":db.type/string" "datomic-schema-type-string" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-string" nil nil)
                       ("dst" ":db.type/ref" "datomic-schema-type-ref" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-ref" nil nil)
                       ("dst" ":db.type/long" "datomic-schema-type-long" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-long" nil nil)
                       ("dst" ":db.type/keyword" "datomic-schema-type-keyword" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-keyword" nil nil)
                       ("dst" ":db.type/instant" "datomic-schema-type-instant" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-instant" nil nil)
                       ("dst" ":db.type/boolean" "datomic-schema-type-boolean" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-type-boolean" nil nil)
                       ("dsf" "{:db/id #db/id[:db.part/user]\n :db/ident :${1:ident}\n :db/doc \"$2\"\n :db/fn #db/fn {:lang \"clojure\"\n                :params [db $3]\n                :code ($0)}}" "datomic-schema-function" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-function" nil nil)
                       ("dsa" "{:db/id #db/id[:db.part/db]\n :db/ident :${1:ident}\n :db/valueType dst$0\n :db/cardinality :db.cardinality/${2:one}\n :db.install/_attribute :db.part/db}" "datomic-schema-attribute" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-attribute" nil nil)
                       (":db" ":db/unique :db.unique/value" "datomic-schema-attr-unique" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-attr-unique" nil nil)
                       (":db" ":db/isComponent true" "datomic-schema-attr-isComponent" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-attr-isComponent" nil nil)
                       (":db" ":db/index true" "datomic-schema-attr-index" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/clojure-mode/datomic-schema-attr-index" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("el" "<%--@elvariable id=\"$1\" type=\"$2\"--%>" "elvariable" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/crappy-jsp-mode/elvariable" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("req" "(require '$0)" "req" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/emacs-lisp-mode/req" nil nil)
                       ("pro" "(provide '`(buffer-file-name-body)`)$0" "provide" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/emacs-lisp-mode/provide.yasnippet" nil nil)
                       ("ends" ";;; `(buffer-file-name-body)`.el ends here$0" "ends" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/emacs-lisp-mode/ends" nil nil)
                       ("auto" ";;;###autoload" "autoload" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/emacs-lisp-mode/autoload" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("sc" "Scenario: $1\n  Given $0\n  When\n  Then" "scenario" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/feature-mode/scenario" nil nil)
                       ("ft" "Feature: $1\n\n  sc$0\n" "feature" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/feature-mode/feature" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("strong" "<strong>$0</strong>" "strong" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/strong" nil nil)
                       ("script" "<script src=\"$0\"></script>" "script" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/script" nil nil)
                       ("mod" "<div class=\"mod\">\n  <div class=\"inner\">\n    <div class=\"bd\">\n      $0\n    </div>\n  </div>\n</div>" "oocss-module" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/oocss-module" nil nil)
                       ("media" "<div class=\"media\">\n  <img src=\"$1\" class=\"img\" alt=\"$2\" />\n  <div class=\"bd\">\n    $0\n  </div>\n</div>" "media" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/media" nil nil)
                       ("link" "<link rel=\"${1:stylesheet}\" href=\"$0\">" "link" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/link" nil nil)
                       ("kbd" "<kbd>$1</kbd>$0" "kbd" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/kbd" nil nil)
                       ("input" "<input type=\"${1:text}\" name=\"$2\" value=\"$0\">" "input" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/input" nil nil)
                       ("inc" "<%@ include file=\"_$0.jsp\" %>" "include" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/include" nil nil)
                       ("html" "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta content=\"IE=edge,chrome=1\" http-equiv=\"X-UA-Compatible\">\n    <title>$1</title>\n  </head>\n  <body>\n    $0\n  </body>\n</html>\n" "html" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/html" nil nil)
                       ("em" "<em>$0</em>" "em" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/em" nil nil)
                       ("code" "<code>$0</code>" "code" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/code" nil nil)
                       ("cif" "<c:if test=\"$1\">$0</c:if>" "c:if" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/c-if" nil nil)
                       ("cfe" "<c:forEach items=\"\\${$1}\" var=\"$2\">\n           $0\n</c:forEach>" "c:forEach" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/html-mode/c-forEach" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("try" "try {\n    $0\n} catch (e) {\n}" "try" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/try" nil nil)
                       ("." "this.$0" "this" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/this.yasnippet" nil nil)
                       ("ppp" "${2:$1}: { value: params.${1:property} },\nppp$0" "object.create-property+" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/object.create-property+" nil nil)
                       ("pp" "${2:$1}: { value: params.${1:property} }$0" "object.create-property" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/object.create-property" nil nil)
                       ("create" "create: function (params) {\n  return Object.create(this, {\n    ppp$0\n  });\n}" "object.create" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/object.create" nil nil)
                       ("req" "var ${3:${1:$(s-lower-camel-case (file-name-nondirectory yas/text))}} = require(\"${1:fs}\")$2;$0" "node.require" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/node.require.yasnippet" nil nil)
                       ("mx" "module.exports = $0;" "node.module.exports" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/node.module.exports.yasnippet" nil nil)
                       ("ifnode" "if (typeof require === \"function\" && typeof module !== \"undefined\") {\n    $0\n}" "node.ifnode" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/node.ifnode.yasnippet" nil nil)
                       ("tc" "(function (${2:${1:$(buster--shortcuts-for-globals yas/text)}}) {\n  testCase(\"${3:`(chop-suffix \"Test\" (upper-camel-case (buffer-file-name-body)))`}$4Test\", sinon.testCase({\n    tt$0\n  }));\n}(${1:`(if buster-add-default-global-to-iife buster-default-global)`}));\n" "jstd.testCase"
                        (not buster-testcase-snippets-enabled)
                        nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/jstd.testCase.yasnippet" nil nil)
                       ("log" "jstestdriver.console.log($0);" "jstd.log" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/jstd.log.yasnippet" nil nil)
                       ("tcc" "testCase(\"${2:`(chop-suffix \"Test\" (upper-camel-case (buffer-file-name-body)))`}$3\", sinon.testCase({\n    tt$0\n}));\n" "jstd.additionalTestCase"
                        (not buster-testcase-snippets-enabled)
                        nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/jstd.additionalTestCase.yasnippet" nil nil)
                       ("doc" "/*:DOC ${1:element} = <${2:div}>$0</$2>*/" "jstd-doc" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/jstd-doc" nil nil)
                       ("ff" "(function (${2:${1:$(buster--shortcuts-for-globals yas/text)}}) {\n    `(buster--maybe-use-strict)\n `$0\n}(${1:`(if buster-add-default-global-to-iife buster-default-global)`}));\n" "immediately-invoked-function-expression" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/immediately-invoked-function-expression.yasnippet" nil nil)
                       ("f" "function ${1:`(snippet--function-name)`}($2) {$0}`(snippet--function-punctuation)`" "function" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/function.yasnippet" nil nil)
                       ("forin" "for (var key in ${1:obj}) {\n  if ($1.hasOwnProperty(key)) {\n    $0\n  }\n}" "for-in" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/for-in" nil nil)
                       ("for" "for (var i = 0, l = ${num}; i < l; i++) {$0}" "for" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/for" nil nil)
                       ("eb" "var $1 = FINN.elementBuilder(\"${1:div}\");$0" "finn-element-builder" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/finn-element-builder" nil nil)
                       ("ng" "angular.module(\"OIIKU_SHARED\")\n    .directive(\"`(s-lower-camel-case (buffer-file-name-body))`\", function (getContextPath) {\n        return {\n            restrict: \"E\",\n            templateUrl: getContextPath(\"angular-shared\") + \"/`(buffer-file-name-body)`.html\",\n            link: function () {\n\n            }\n        };\n    });" "directive-oiiku-shared" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/directive-oiiku-shared" nil nil)
                       ("dg" "var ${1:`buster-default-global`} = this.$1 || {};" "declare-global" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/js-mode/declare-global.yasnippet" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("post" "---\nlayout: post\ntitle: \"$1\"\ndate: `(substring (buffer-file-name-body) 0 10)` `(substring (current-time-string) 11 16)`\ncomments: true\n---\n{% img imgs /photos/`(substring (buffer-file-name-body) 0 10)`-`(substring (buffer-file-name-body) 11)`-1.jpg %}\n$0\n" "octopress-post" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/markdown-mode/octopress-post" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("req" "require_once(dirname(__FILE__) . \"/$1.php\");$0" "req" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/php-mode/req" nil nil)
                       ("f" "public function ${1:name}($2) {\n       $0\n}" "public function" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/php-mode/public-function" nil nil)
                       ("pri" "private function ${1:name}($2) {\n        $0\n}" "private-function" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/php-mode/private-function" nil nil)
                       ("funs" "public static function ${1:name}($2) {\n  $0\n}" "funs" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/php-mode/funs" nil nil)
                       ("fun" "public function ${1:name}($2) {\n  $0\n}" "fun" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/php-mode/fun" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'snippets
                     '(("tc" "require 'test/unit'\nrequire '$1'\n\nclass ${1:$(upper-camel-case yas/text)}TestCase < Test::Unit::TestCase\n\n  tt$0\n\nend" "testcase" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/testcase" nil nil)
                       ("do" "do ${1:|$2|}\n  $0\nend" "do-block" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/do-block" nil nil)
                       ("tt" "def test_$1\n  $0\nend\n" "tt" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/deftest" nil nil)
                       ("defs" "def self.$1($2)\n  $0\nend" "def.self" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/def.self" nil nil)
                       ("def" "def $1\n    $0\nend" "def" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/def" nil nil)
                       ("cla" "class `(s-upper-camel-case (buffer-file-name-body))`\n  $0\nend" "class" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/class" nil nil)
                       ("ase" "assert_equal ${1:expected}, ${2:actual}$0" "assert_equal" nil nil nil "/home/jcp/.spacemacs.d/snippets/snippets/ruby-mode/assert_equal" nil nil)))


;;; Do not edit! File generated at Mon May  8 21:29:14 2017
