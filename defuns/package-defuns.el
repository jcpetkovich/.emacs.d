
(require 'package)
(require 'dash)

(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives melpa)

(package-initialize)

(defun packages-install (packages)
  (--each packages
    (when (not (package-installed-p name))
      (package-install name)))
  (delete-other-windows))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;;; Prettyish highlighting for require-package
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("(\\(require-package\\)\\>" 1 font-lock-builtin-face)))

(provide 'package-defuns)
