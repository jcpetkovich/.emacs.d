;;; Compiled snippets and support files for `html-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'html-mode
                     '(("cfe" "<c:forEach items=\"\\${$1}\" var=\"$2\">\n           $0\n</c:forEach>" "c:forEach" nil nil nil nil nil nil)
                       ("cif" "<c:if test=\"$1\">$0</c:if>" "c:if" nil nil nil nil nil nil)
                       ("code" "<code>$0</code>" "code" nil nil nil nil nil nil)
                       ("em" "<em>$0</em>" "em" nil nil nil nil nil nil)
                       ("html" "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta content=\"IE=edge,chrome=1\" http-equiv=\"X-UA-Compatible\">\n    <title>$1</title>\n  </head>\n  <body>\n    $0\n  </body>\n</html>\n" "html" nil nil nil nil nil nil)
                       ("inc" "<%@ include file=\"_$0.jsp\" %>" "include" nil nil nil nil nil nil)
                       ("input" "<input type=\"${1:text}\" name=\"$2\" value=\"$0\">" "input" nil nil nil nil nil nil)
                       ("kbd" "<kbd>$1</kbd>$0" "kbd" nil nil nil nil nil nil)
                       ("media" "<div class=\"media\">\n  <img src=\"$1\" class=\"img\" alt=\"$2\" />\n  <div class=\"bd\">\n    $0\n  </div>\n</div>" "media" nil nil nil nil nil nil)
                       ("mod" "<div class=\"mod\">\n  <div class=\"inner\">\n    <div class=\"bd\">\n      $0\n    </div>\n  </div>\n</div>" "oocss-module" nil nil nil nil nil nil)
                       ("script" "<script src=\"$0\"></script>" "script" nil nil nil nil nil nil)
                       ("strong" "<strong>$0</strong>" "strong" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Tue Mar 18 12:42:22 2014
