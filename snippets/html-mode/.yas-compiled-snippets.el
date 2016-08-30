;;; Compiled snippets and support files for `html-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'html-mode
                     '(("strong" "<strong>$0</strong>" "strong" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/strong" nil nil)
                       ("script" "<script src=\"$0\"></script>" "script" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/script" nil nil)
                       ("mod" "<div class=\"mod\">\n  <div class=\"inner\">\n    <div class=\"bd\">\n      $0\n    </div>\n  </div>\n</div>" "oocss-module" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/oocss-module" nil nil)
                       ("media" "<div class=\"media\">\n  <img src=\"$1\" class=\"img\" alt=\"$2\" />\n  <div class=\"bd\">\n    $0\n  </div>\n</div>" "media" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/media" nil nil)
                       ("kbd" "<kbd>$1</kbd>$0" "kbd" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/kbd" nil nil)
                       ("input" "<input type=\"${1:text}\" name=\"$2\" value=\"$0\">" "input" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/input" nil nil)
                       ("inc" "<%@ include file=\"_$0.jsp\" %>" "include" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/include" nil nil)
                       ("html" "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta content=\"IE=edge,chrome=1\" http-equiv=\"X-UA-Compatible\">\n    <title>$1</title>\n  </head>\n  <body>\n    $0\n  </body>\n</html>\n" "html" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/html" nil nil)
                       ("em" "<em>$0</em>" "em" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/em" nil nil)
                       ("code" "<code>$0</code>" "code" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/code" nil nil)
                       ("cif" "<c:if test=\"$1\">$0</c:if>" "c:if" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/c-if" nil nil)
                       ("cfe" "<c:forEach items=\"\\${$1}\" var=\"$2\">\n           $0\n</c:forEach>" "c:forEach" nil nil nil "/home/jcp/.spacemacs.d/snippets/html-mode/c-forEach" nil nil)))


;;; Do not edit! File generated at Tue Aug 23 09:39:36 2016
