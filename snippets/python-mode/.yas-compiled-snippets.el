;;; Compiled snippets and support files for `python-mode'
;;; contents of the .yas-setup.el support file:
;;;
(defun python-split-args (arg-string)
  "Split a python argument string into ((name, default)..) tuples"
  (mapcar (lambda (x)
             (split-string x "[[:blank:]]*=[[:blank:]]*" t))
          (split-string arg-string "[[:blank:]]*,[[:blank:]]*" t)))

(defun python-args-to-docstring ()
  "return docstring format for the python arguments in yas-text"
  (let* ((indent (concat "\n" (make-string (current-column) 32)))
         (args (python-split-args yas-text))
         (max-len (if args (apply 'max (mapcar (lambda (x) (length (nth 0 x))) args)) 0))
         (formatted-args (mapconcat
                (lambda (x)
                   (concat (nth 0 x) (make-string (- max-len (length (nth 0 x))) ? ) " -- "
                           (if (nth 1 x) (concat "\(default " (nth 1 x) "\)"))))
                args
                indent)))
    (unless (string= formatted-args "")
      (mapconcat 'identity (list "Keyword Arguments:" formatted-args) indent))))

(add-hook 'python-mode-hook
          '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)))
;;; Snippet definitions:
;;;
(yas-define-snippets 'python-mode
                     '(("tc" "class Test${1:Class}(${2:unittest.TestCase}):\n    $0\n" "test class" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/tc" nil nil)
                       ("t" "def test_${1:}(self$2):\n    $0\n" "test" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/t" nil nil)
                       ("prop" "def ${1:foo}():\n    doc = \"\"\"${2:Doc string}\"\"\"\n    def fget(self):\n        return self._$1\n\n    def fset(self, value):\n        self._$1 = value\n\n    def fdel(self):\n        del self._$1\n    return locals()\n$1 = property(**$1())\n\n$0\n" "prop" nil nil nil "/home/jcp/.spacemacs.d/snippets/python-mode/prop" nil nil)
                       ("m" "def ${1:method}(self$2):\n    $0\n" "method" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/m" nil nil)
                       ("l" "for ${1:x} in ${2:l}:\n    $0\n" "forloop" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/l" nil nil)
                       ("i" "if ${1:condition}:\n    $0\n" "if" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/i" nil nil)
                       ("f" "def ${1:fun}(${2:args}):\n    $0\n" "function" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/f" nil nil)
                       ("e" "try:\n    $1\nexcept$2:\n    $0\n" "trycatch" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/e" nil nil)
                       ("defdoc" "def ${1:name}($2):\n    \"\"\"\n    $3\n    ${2:$(let* ((indent\n            (concat \"\\n\" (make-string (current-column) 32)))\n           (args\n            (mapconcat\n             '(lambda (x)\n                (if (not (string= (nth 0 x) \"\"))\n                    (concat (nth 0 x) \" : (type)\" indent (make-string python-indent 32) \"description\")))\n             (mapcar\n              '(lambda (x)\n                 (mapcar\n                  '(lambda (x)\n                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"\n                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))\n                  x))\n              (mapcar '(lambda (x) (split-string x \"=\"))\n                      (split-string yas-text \",\")))\n             indent)))\n      (if (string= args \"\")\n          (concat indent \"Returns\" indent \"-------\" indent \"(type)\" indent (make-string 3 34))\n        (mapconcat\n         'identity\n         (list \"Parameters\" \"----------\" args \"\" \"Returns\" \"-------\" \"(type)\" (make-string 3 34))\n         indent)))}\n    $0" "defdoc" nil nil nil "/home/jcp/.spacemacs.d/snippets/python-mode/defdoc" nil nil)
                       ("c" "class ${1:Class}(${2:object}):\n    $0\n" "class" nil
                        ("definitions")
                        nil "/home/jcp/.spacemacs.d/snippets/python-mode/c" nil nil)
                       ("arguments" "from optparse import OptionParser\nusage = \"usage: %prog [options] $1\"\nparser = OptionParser(description = \"$2\", usage = usage)\nparser.add_option(\"-o\", \"--outfile\", dest = \"outfile\",\n                  help = \"write output to FILE\", metavar = \"FILE\")\nparser.add_option(\"-v\", \"--verbose\", dest = \"verbose\",\n                  action = \"store_true\", default = False,\n                  help = \"be verbose.\")\n(options, args) = parser.parse_args()" "arguments" nil nil nil "/home/jcp/.spacemacs.d/snippets/python-mode/arguments" nil nil)))


;;; Do not edit! File generated at Wed Jul 26 13:54:08 2017
