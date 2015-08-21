;;; extensions.el --- c-extras Layer extensions File for Spacemacs
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

(defvar c-extras-pre-extensions
  '(
    ;; pre extension c-extrass go here
    )
  "List of all extensions to load before the packages.")

(defvar c-extras-post-extensions
  '(
    ;; post extension c-extrass go here
    cc-mode
    )
  "List of all extensions to load after the packages.")

(defun c-extras/post-init-cc-mode ()
  (use-package cc-mode
    :commands (c-mode c++-mode)
    :config
    (progn
      (add-hook 'c-mode-hook (defun user-utils/turn-off-abbrev-mode ()
                               (abbrev-mode -1)))

      (defvar c-extras/linux-source-locations nil
        "Path's to linux source used for pattern matching.")

      ;; By default, follow bsd style
      (setq-default c-default-style '((java-mode . "java")
                                      (awk-mode . "awk")
                                      (c++-mode . "google")
                                      (other . "bsd"))

                    c-extras/linux-source-locations '("~/labs/linux-trees"
                                                      "/usr/src/linux"))

      (defun c-extras/c-lineup-arglist-tabs-only (ignored)
        "Line up argument lists by tabs, not spaces. This is mainly
for the Linux Kernel style guidelines."
        (let* ((anchor (c-langelem-pos c-syntactic-element))
               (column (c-langelem-2nd-pos c-syntactic-element))
               (offset (- (1+ column) anchor))
               (steps (floor offset c-basic-offset)))
          (* (max steps 1)
             c-basic-offset))))

    (add-hook 'c-mode-common-hook
              (defun c-extras/linux-source-styling ()
                ;; Add kernel style
                (c-add-style
                 "linux-tabs-only"
                 '("linux" (c-offsets-alist
                            (arglist-cont-nonempty
                             c-lineup-gcc-asm-reg
                             c-extras/c-lineup-arglist-tabs-only))))))

    (add-hook 'c-mode-hook
              (defun c-extras/setup-default-c-indentation ()
                ;; tab width 8 in C please
                (set (make-local-variable 'tab-width) 8)
                (set (make-local-variable 'indent-tabs-mode) t)
                (let ((filename (buffer-file-name)))

                  ;; Enable kernel mode for the appropriate files
                  (when (and filename
                             (-any-p (lambda (path) (string-match (expand-file-name path) filename))
                                     c-extras/linux-source-locations))
                    (smart-tabs-mode -1)
                    (c-set-style "linux-tabs-only")))))


    (add-hook 'c++-mode-hook
              (lambda ()
                (set (make-local-variable 'tab-width) 2)
                (set (make-local-variable 'indent-tabs-mode) nil)))))
