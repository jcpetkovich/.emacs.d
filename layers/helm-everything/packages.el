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
    helm
    helm-cmd-t
    helm-descbinds
    helm-swoop
    helm-gtags
    wgrep-helm
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar helm-everything-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function helm-everything/init-<package-helm-everything>

(defun helm-everything/init-helm-swoop ()
  "Initialize helm-swoop"
  (use-package helm-swoop
    :defer t
    :config
    (setq-default helm-swoop-speed-or-color t)))

(defun helm-everything/init-helm-descbinds ()
  "Initialize helm-descbinds"
  (use-package helm-descbinds
    :defer t
    :config
    (helm-descbinds-mode 1)))

(defun helm-everything/init-helm-cmd-t ()
  "Initialize helm-cmd-t"
  (use-package helm-C-x-b
    :commands (helm-C-x-b)
    :config
    (setf helm-C-x-b-sources (--remove (eq it 'helm-source-cmd-t) helm-C-x-b-sources)
          helm-C-x-b-sources (-insert-at 1 'helm-source-recentf helm-C-x-b-sources)))

  (use-package helm-cmd-t
    :commands (helm-cmd-t)
    :config
    (progn
      (unless helm-source-buffers-list
        (setq helm-source-buffers-list
              (helm-make-source "Buffers" 'helm-source-buffers))))))

(defun helm-everything/init-helm ()
  "Initialize helm"
  (use-package helm
    :defer t
    :init
    (progn

      ;; A few possibly unfriendly remaps, so guard with a variable
      (if helm-everything/really-everything
          (bind-keys
           ([remap occur]             . helm-occur)
           ([remap jump-to-register]  . helm-register)
           ([remap find-tag]          . helm-etags-select)
           ([remap ido-find-file]     . helm-find-files)
           ([remap ido-kill-buffer]   . kill-buffer)
           ([remap ido-switch-buffer] . helm-C-x-b)
           ([remap rgrep]             . helm-do-grep)
           ("M-x"                     . helm-M-x)
           ("M-y"                     . helm-show-kill-ring)
           ("C-x k"                   . kill-buffer)
           ("C-x C-f"                 . helm-find-files)
           ("C-h r"                   . helm-info-emacs)
           ("C-h d"                   . helm-info-at-point)
           ("C-x C-d"                 . helm-browse-project)
           ("C-h C-f"                 . helm-apropos)
           ("C-h a"                   . helm-apropos))))

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
            helm-candidate-number-limit 20
            helm-ff-search-library-in-sexp t
            helm-ff-file-name-history-use-recentf t
            helm-home-url "https://www.google.ca"
            helm-follow-mode-persistent t

            ;; fuzzy completion
            helm-M-x-fuzzy-match t
            helm-apropos-fuzzy-match t
            helm-buffers-fuzzy-matching t
            helm-lisp-fuzzy-completion t
            helm-recentf-fuzzy-match t)))

  (use-package helm-man
    :defer t
    :init
    (progn
      (defun helm-everything/helm-man-woman (arg)
        "Preconfigured `helm' for Man and Woman pages.
With a prefix arg reinitialize the cache."
        (interactive "P")
        (require 'helm-man)
        (require 'helm-swoop)
        (when arg (setq helm-man-pages nil))
        (helm :sources 'helm-source-man-pages
              :buffer "*Helm man woman*"
              :input (helm-swoop-pre-input-optimize (thing-at-point 'symbol))))
      (bind-key "K" 'helm-everything/helm-man-woman evil-normal-state-map))
    :config
    (progn
      (setq-default helm-man-or-woman-function 'woman))))

(defun helm-everything/init-helm-gtags ()
  (use-package helm-gtags
    :defer t
    :init
    (progn
      (defvar helm-everything/additional-gtags-modes
        '(coffee-mode-hook
          cperl-mode-hook
          sh-mode-hook))
      (--each helm-everything/additional-gtags-modes
          (add-hook it 'helm-gtags-mode)))


    :config
    (--each helm-everything/additional-gtags-modes
      (spacemacs/gtags-define-keys-for-mode it))))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
