;;; Compiled snippets and support files for `markdown-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'markdown-mode
                     '(("post" "---\nlayout: post\ntitle: \"$1\"\ndate: `(substring (buffer-file-name-body) 0 10)` `(substring (current-time-string) 11 16)`\ncomments: true\n---\n{% img imgs /photos/`(substring (buffer-file-name-body) 0 10)`-`(substring (buffer-file-name-body) 11)`-1.jpg %}\n$0\n" "octopress-post" nil nil nil "/home/jcp/.spacemacs.d/snippets/markdown-mode/octopress-post" nil nil)))


;;; Do not edit! File generated at Wed Dec 13 16:35:20 2017
