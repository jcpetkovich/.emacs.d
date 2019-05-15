;;; packages.el --- c-extras Layer packages File for Spacemacs
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

(setq c-extras-packages
      '(
        company
        smart-tabs-mode
        clang-format
        google-c-style
        ycmd
        (cc-mode :location built-in)
        )
      )

(setq c-extras-excluded-packages '())

(defun c-extras/post-init-company ()
  (use-package company
    :defer t
    :init (add-hook 'c-mode-common-hook
                    (defun c-extras/slow-company-mode ()
                      "Slow down company mode in c-mode like
                      things, it's way too aggressive."
                      (--each '(indentation space-after-tab)
                        (set (make-local-variable 'whitespace-style) (remove it whitespace-style)))))))

(defun c-extras/init-smart-tabs-mode ()
  (use-package smart-tabs-mode
    :init
    (progn
      (defvar c-extras/smart-tabs-enabled nil)
      (add-hook 'c-mode-common-hook
                (defun c-extras/enable-smart-tabs-mode ()
                  (when (not c-extras/smart-tabs-enabled)
                    (setq c-extras/smart-tabs-enabled t)
                    (smart-tabs-insinuate 'c)))))))

(defun c-extras/post-init-ycmd ()
  (use-package ycmd
    :defer t
    :init (setq-default ycmd-server-command '("python2" "/home/jcp/labs/ycmd/ycmd/"))))

(defun c-extras/post-init-clang-format ()
  (use-package clang-format
    :defer t
    :commands clang-format-buffer
    :init
    (progn
      (defun clang-format-before-save ()
        (interactive)
        (when (eq major-mode 'c++-mode) (clang-format-buffer)))
      (add-hook 'before-save-hook 'clang-format-before-save))))

(defun c-extras/post-init-google-c-style ()
  (use-package google-c-style
    :defer t
    :init
    (c-add-style "Google" google-c-style)))

(defun c-extras/personal-java-mode-setup ()
  (setenv "JAVA_HOME" "/usr/lib64/openjdk-11/")
  (setq meghanada-java-path (format "%s/bin/java" (getenv "JAVA_HOME")))
  (setq lsp-java-java-path (format "%s/bin/java" (getenv "JAVA_HOME")))
  (setq lsp-java-theme nil)
  (defun personal-java-setup ()
    (setq-local c-basic-offset 2))
  (add-hook 'java-mode-hook 'personal-java-setup))

(defun c-extras/post-init-cc-mode ()
  (use-package cc-mode
    :commands (c-mode c++-mode)
    :config
    (progn
      (add-hook 'c-mode-hook (defun user-utils/turn-off-abbrev-mode ()
                               (abbrev-mode -1)))

      ;; call java setup
      (c-extras/personal-java-mode-setup)

      (bind-keys :map c++-mode-map
                 ("M-j" . personal/move-cursor-next-pane)
                 ("M-k" . personal/move-cursor-previous-pane))

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
