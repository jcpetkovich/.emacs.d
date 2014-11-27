;;; Compiled snippets and support files for `php-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'php-mode
                     '(("fun" "public function ${1:name}($2) {\n  $0\n}" "fun" nil nil nil nil nil nil)
                       ("funs" "public static function ${1:name}($2) {\n  $0\n}" "funs" nil nil nil nil nil nil)
                       ("pri" "private function ${1:name}($2) {\n        $0\n}" "private-function" nil nil nil nil nil nil)
                       ("f" "public function ${1:name}($2) {\n       $0\n}" "public function" nil nil nil nil nil nil)
                       ("req" "require_once(dirname(__FILE__) . \"/$1.php\");$0" "req" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Nov 27 15:58:02 2014
