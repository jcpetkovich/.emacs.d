;;; extensions.el --- python-extras Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar python-extras-pre-extensions
  '(
    ;; pre extension python-extrass go here
    )
  "List of all extensions to load before the packages.")

(defvar python-extras-post-extensions
  '(
    ;; post extension python-extrass go here
    python
    )
  "List of all extensions to load after the packages.")

(defun python-extras/post-init-python ()
  (use-package python
    :config
    (progn
      (defun python-extras/smart-delete ()
        (interactive)
        (let ((valid-pairs (sp--get-pair-list)))
          (if (--any-p
               (sp--looking-back (sp--strict-regexp-quote (cdr it)))
               valid-pairs)
              (sp-backward-delete-char)
            (call-interactively 'python-indent-dedent-line-backspace))))

      (bind-key "<backspace>" 'python-extras/smart-delete python-mode-map))))

;; For each extension, define a function python-extras/init-<extension-python-extras>
;;
;; (defun python-extras/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
