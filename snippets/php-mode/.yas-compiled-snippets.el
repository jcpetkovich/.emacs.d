;;; Compiled snippets and support files for `php-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'php-mode
                     '(("req" "require_once(dirname(__FILE__) . \"/$1.php\");$0" "req" nil nil nil "/home/jcp/.spacemacs.d/snippets/php-mode/req" nil nil)
                       ("f" "public function ${1:name}($2) {\n       $0\n}" "public function" nil nil nil "/home/jcp/.spacemacs.d/snippets/php-mode/public-function" nil nil)
                       ("pri" "private function ${1:name}($2) {\n        $0\n}" "private-function" nil nil nil "/home/jcp/.spacemacs.d/snippets/php-mode/private-function" nil nil)
                       ("funs" "public static function ${1:name}($2) {\n  $0\n}" "funs" nil nil nil "/home/jcp/.spacemacs.d/snippets/php-mode/funs" nil nil)
                       ("fun" "public function ${1:name}($2) {\n  $0\n}" "fun" nil nil nil "/home/jcp/.spacemacs.d/snippets/php-mode/fun" nil nil)))


;;; Do not edit! File generated at Wed Sep 14 22:51:20 2016
