;; =============================================================
;; Slime options
;; =============================================================
(setq inferior-lisp-program "/usr/bin/sbcl --noinform --no-linedit") ; change the default inferior common-lisp interpreter
 
(defun lisp-enable-paredit-hook () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(font-lock-add-keywords 'lisp-mode
  '(("(\\(iter\\)\\>" 1 font-lock-keyword-face)))

(font-lock-add-keywords 'lisp-mode
  '(("(\\(->>\\)\\>" 1 font-lock-keyword-face)))

(font-lock-add-keywords 'lisp-mode
  '(("(\\(->\\)\\>" 1 font-lock-keyword-face)))

;; ;;; all code in this function lifted from the clojure-mode function
;; ;;; from clojure-mode.el
;; (defun clojure-font-lock-setup ()
;;   (interactive)
;;   (set (make-local-variable 'lisp-indent-function)
;;        'clojure-indent-function)
;;   (set (make-local-variable 'lisp-doc-string-elt-property)
;;        'clojure-doc-string-elt)
;;   (set (make-local-variable 'font-lock-multiline) t)
 
;;   (add-to-list 'font-lock-extend-region-functions
;;                'clojure-font-lock-extend-region-def t)
 
;;   (when clojure-mode-font-lock-comment-sexp
;;     (add-to-list 'font-lock-extend-region-functions
;;                  'clojure-font-lock-extend-region-comment t)
;;     (make-local-variable 'clojure-font-lock-keywords)
;;     (add-to-list 'clojure-font-lock-keywords
;;                  'clojure-font-lock-mark-comment t)
;;     (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))
 
;;   (setq font-lock-defaults
;;         '(clojure-font-lock-keywords ; keywords
;;           nil nil
;;           (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist
;;           nil
;;           (font-lock-mark-block-function . mark-defun)
;;           (font-lock-syntactic-face-function
;;            . lisp-font-lock-syntactic-face-function))))
 
;; (add-hook 'slime-repl-mode-hook
;;           (lambda ()
;;             (font-lock-mode nil)
;;             (clojure-font-lock-setup)
;;             (font-lock-mode t)))


;;; Clojure slime stuff
;; (add-to-list 'load-path "~/src/clojure/slime/")  ; your SLIME directory
;; (setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
;; (require 'slime)
;; (slime-setup '(slime-fancy slime-asdf slime-banner))
;; (setq common-lisp-hyperspec-root
;;       (if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
;;           "file:///usr/share/doc/hyperspec/HyperSpec/"
;;         "http://www.lispworks.com/reference/HyperSpec/"))
