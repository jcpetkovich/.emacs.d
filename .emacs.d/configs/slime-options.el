;; ============================================================= 
;; Slime options
;; ============================================================= 
(setq inferior-lisp-program "/usr/bin/sbcl") ; change the default inferior common-lisp interpreter

(defun slime-prep ()
  ""
  (interactive)
  (require 'slime)
  (slime-setup))

(defun myslime ()
  "MY SLIME! DO IT NOOOOOOOOOOOW!"
  (interactive)
  (cd "~/src/clojure") ;dirty hack to satisfy clojure
  (slime)
  (cd "~/"))

;; Clojure/slime classpath
(setf swank-clojure-classpath '("/home/jcp/src/clojure/src/examples" "/home/jcp/src/clojure" "/home/jcp/src/clojure/src/" "/home/jcp/src/clojure/classes" "/home/jcp/.swank-clojure/clojure-1.1.0-master-20091202.150145-1.jar" "/home/jcp/.swank-clojure/clojure-contrib-1.1.0-master-20091212.205045-1.jar" "/home/jcp/.swank-clojure/swank-clojure-1.1.0.jar" "."))

;; Fix slime hooks for viper-mode
(add-hook 'slime-repl-mode-hook 'viper-change-state-to-vi)
(add-hook 'slime-mode-hook 'viper-change-state-to-vi)
