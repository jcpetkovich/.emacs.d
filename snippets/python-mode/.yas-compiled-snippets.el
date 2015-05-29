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
                     '(("c" "class ${1:Class}(${2:object}):\n    $0\n" "class" nil
                        ("definitions")
                        nil nil nil nil)
                       ("e" "try:\n    $1\nexcept$2:\n    $0\n" "trycatch" nil
                        ("definitions")
                        nil nil nil nil)
                       ("f" "def ${1:fun}(${2:args}):\n    $0\n" "function" nil
                        ("definitions")
                        nil nil nil nil)
                       ("i" "if ${1:condition}:\n    $0\n" "if" nil
                        ("definitions")
                        nil nil nil nil)
                       ("l" "for ${1:x} in ${2:l}:\n    $0\n" "forloop" nil
                        ("definitions")
                        nil nil nil nil)
                       ("m" "def ${1:method}(self$2):\n    $0\n" "method" nil
                        ("definitions")
                        nil nil nil nil)
                       ("prop" "def ${1:foo}():\n    doc = \"\"\"${2:Doc string}\"\"\"\n    def fget(self):\n        return self._$1\n\n    def fset(self, value):\n        self._$1 = value\n\n    def fdel(self):\n        del self._$1\n    return locals()\n$1 = property(**$1())\n\n$0\n" "prop" nil nil nil nil nil nil)
                       ("t" "def test_${1:}(self$2):\n    $0\n" "test" nil
                        ("definitions")
                        nil nil nil nil)
                       ("tc" "class Test${1:Class}(${2:unittest.TestCase}):\n    $0\n" "test class" nil
                        ("definitions")
                        nil nil nil nil)))


;;; Do not edit! File generated at Fri May 29 16:55:12 2015
