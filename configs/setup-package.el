
(require 'package)

(defvar marmalade '("marmalade" . "http://marmalade-repo.org/packages/"))
(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives marmalade)
(add-to-list 'package-archives melpa)

(package-initialize)

(unless (and (file-exists-p "~/.emacs.d/elpa/archives/marmalade")
             (file-exists-p "~/.emacs.d/elpa/archives/gnu")
             (file-exists-p "~/.emacs.d/elpa/archives/melpa"))
  (package-refresh-contents))

(defun packages-install (&rest packages)
  (mapc (lambda (package)
          (let ((name (car package))
                (repo (cdr package)))
            (when (not (package-installed-p name))
              (let ((package-archives (list repo)))
                (package-initialize)
                (package-install name)))))
        packages)
  (package-initialize)
  (delete-other-windows))

(packages-install
 (cons 'clojure-mode melpa)
 (cons 'nrepl melpa)
 (cons 'ac-nrepl melpa)
 (cons 'auctex gnu)
 (cons 'ess melpa)
 (cons 'inf-ruby melpa)
 (cons 'org melpa)
 (cons 'paredit melpa)
 (cons 'python-mode marmalade)
 (cons 'slime-js marmalade)
 (cons 'slime-repl marmalade)
 (cons 'smartparens melpa)
 (cons 'markdown-mode marmalade)
 (cons 'rust-mode melpa))

(provide 'setup-package)
