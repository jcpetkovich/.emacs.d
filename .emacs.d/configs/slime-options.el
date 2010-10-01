;; =============================================================
;; Slime options
;; =============================================================
(setq inferior-lisp-program "/usr/bin/sbcl") ; change the default inferior common-lisp interpreter
 

;; ;; in the .emacs file, clojure configuration
;; ;; to run slime, M-- M-x slime then type clojure

;; ;;tells emacs where to find clojure-mode.el
;; ;; (add-to-list 'load-path "~/clj/clojure-mode")
;; (require 'clojure-mode)

;; (setq swank-clojure-jar-home "~/.swank-clojure")
;; ;; need to override default deps so self-install is not evoked
;; ;; the URLs are honestly arbitrary, I essentially just removed
;; ;; the version info so that the filenames match the filenames
;; ;; of the jars I built
;; (setq swank-clojure-deps
;;       (list (concat "http://repo.technomancy.us/"
;;                     "swank-clojure-1.1.0.jar")
;;             (concat "http://build.clojure.org/snapshots/org/"
;;                     "clojure.jar")
;;             (concat "http://build.clojure.org/snapshots/org/"
;;                     "clojure-contrib.jar")))
;; (add-to-list 'load-path "~/.emacs.d/elpa/swank-clojure-1.1.0")
;; (require 'swank-clojure)
;; ;; needed for overriding default method for invoking slime
;; (ad-activate 'slime-read-interactive-args)



;; (defun slime-prep ()
;;   ""
;;   (interactive)
;;   (require 'slime)
;;   (slime-setup))
 
;; (defun myslime ()
;;   "MY SLIME! DO IT NOOOOOOOOOOOW!"
;;   (interactive)
;;   (cd "~/src/clojure") ;dirty hack to satisfy clojure
;;   (slime)
;;   (cd "~/"))
 
;; ;; Clojure/slime classpath
;; (setf swank-clojure-classpath '("/home/jcp/src/clojure/src/examples" 
;;                                 "/home/jcp/src/clojure" 
;;                                 "/home/jcp/src/clojure/src/" 
;;                                 "/home/jcp/src/clojure/classes" 
;;                                 "/home/jcp/.swank-clojure/clojure-1.1.0-master-20091202.150145-1.jar" 
;;                                 "/home/jcp/.swank-clojure/clojure-contrib-1.1.0-master-20091212.205045-1.jar" 
;;                                 "/home/jcp/.swank-clojure/swank-clojure-1.1.0.jar" 
;;                                 "/home/jcp/src/clojure/src/incanter/modules/incanter-app/target/incanter-app-1.0.0.jar"
;;                                 "."))
 
;; ;; Fix slime hooks for viper-mode
(add-hook 'slime-repl-mode-hook 'viper-change-state-to-vi)
(add-hook 'slime-mode-hook 'viper-change-state-to-vi)

;; ;;; add paredit to slime repl -- not working as intended...
;; ;; (add-hook 'slime-repl-mode-hook 'paredit-mode)

;; ;;; Fix paredit for clojure style braces
;; (add-hook 'slime-mode-hook 
;;           (lambda () 
;;             (viper-add-local-keys 'insert-state '(("{" . paredit-open-curly)
;;                                                   ("}" . paredit-close-curly)))))
;; ;;; not working as intended...
;; ;; (add-hook 'slime-repl-mode-hook
;; ;;           (lambda () 
;; ;;             (viper-add-local-keys 'insert-state '(("{" . paredit-open-curly)
;; ;;                                                   ("}" . paredit-close-curly)))))


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
