;; ============================================================= 
;; Slime options
;; ============================================================= 
(setq inferior-lisp-program "/usr/bin/sbcl") ; change the default inferior common-lisp interpreter

(defun slime-prep ()
  ""
  (interactive)
  (require 'slime)
  (slime-setup))
