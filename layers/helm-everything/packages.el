;;; packages.el --- helm-everything Layer packages File for Spacemacs
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

(defvar helm-everything-packages
  '(
    ;; package helm-everythings go here
    wgrep-helm
    helm-swoop
    helm-descbinds
    helm-proc
    helm-company
    helm
    helm-cmd-t
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar helm-everything-excluded-packages '()
  "List of packages to exclude.")

(defun helm-everything/swoop-no-arg (arg)
  "Helm swoop, but without a default argument"
  (interactive "P")
  (if arg
      (helm-swoop :$multiline nil)
    (helm-swoop :$query "" :$multiline nil)))

;; For each package, define a function helm-everything/init-<package-helm-everything>

(defun helm-everything/init-helm-swoop ()
  "Initialize helm-swoop"
  (use-package helm-swoop
    :defer t))

(defun helm-everything/init-helm-descbinds ()
  "Initialize helm-descbinds"
  (use-package helm-descbinds
    :defer t
    :init
    (progn
      (evil-leader/set-key "hdb" 'helm-descbinds)
      (helm-descbinds-mode 1))))

(defun helm-everything/init-helm-man ()
  "Initialize helm-man"
  (use-package helm-man
    :config (setq-default helm-man-or-woman-function 'woman)))

(defun helm-everything/init-helm ()
  "Initialize helm"
  (use-package helm
    :init
    (progn
      (bind-keys
       ("M-x"       . helm-M-x)
       ("M-y"       . helm-show-kill-ring)
       ("C-x C-f"   . helm-find-files)
       ("C-h r"     . helm-info-emacs)
       ("C-h d"     . helm-info-at-point)
       ("C-x C-d"   . helm-browse-project)
       ("C-h C-f"   . helm-apropos)
       ("C-h a"     . helm-apropos)))

    :config
    (progn

    (require 'helm-tags)
    (require 'helm-regexp)
    (require 'helm-grep)
    (require 'helm-files)
    (require 'helm-man)

    (helm-mode 1)
    (helm-adaptive-mode 1)
    (recentf-mode 1)

    (setq helm-quick-update t
          helm-idle-delay 0.01
          helm-input-idle-delay 0.01
          helm-m-occur-idle-delay 0.01
          helm-exit-idle-delay 0.1
          helm-candidate-number-limit 200
          helm-ff-search-library-in-sexp t
          helm-ff-file-name-history-use-recentf t
          helm-home-url "https://www.google.ca"
          helm-follow-mode-persistent t

          ;; fuzzy completion
          helm-M-x-fuzzy-match t
          helm-apropos-fuzzy-match t
          helm-buffers-fuzzy-matching t
          helm-lisp-fuzzy-completion t
          helm-recentf-fuzzy-match t)
    
      )
    ))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
