
(defvar paren-face 'paren-face)

(defface paren-face
  '((((class color))
     (:foreground "DimGray")))
  "Face for displaying a paren."
  :group 'faces)

(defmacro paren-face-add-support (keywords)
  "Generate a lambda expression for use in a hook."
  `(lambda ()
     (let* ((regexp "(\\|)")
            (match (assoc regexp ,keywords)))
       (unless (eq (cdr match) paren-face)
         (setq ,keywords (append (list (cons regexp paren-face)) ,keywords))))))

;; Keep the compiler quiet.
(eval-when-compile
  (defvar scheme-font-lock-keywords-2 nil)
  (defvar lisp-font-lock-keywords-2 nil))

(add-hook 'scheme-mode-hook (paren-face-add-support scheme-font-lock-keywords-2))

(dolist (for-mode '(lisp-mode-hook emacs-lisp-mode-hook lisp-interaction-mode-hook))
  (add-hook for-mode
            (paren-face-add-support lisp-font-lock-keywords-2)))

(add-hook 'clojure-mode-hook (paren-face-add-support clojure-font-lock-keywords))

(provide 'setup-parenface)

