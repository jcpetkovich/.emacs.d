;;; packages.el --- eshell Layer packages File for Spacemacs
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

(setq eshell-packages
  '(
    (eshell :location built-in)
    (esh-opt :location built-in)
    (em-prompt :location built-in)
    (em-term :location built-in)
    (em-cmpl :location built-in)
    (esh-mode :location built-in)
    ;; package eshells go here
    )
  )

(setq eshell-excluded-packages '())

(defun eshell/init-esh-mode ()
  (use-package esh-mode
    :defer t
    :config
    (add-hook 'eshell-mode-hook
              (defun eshell/fix-keys ()
                (bind-key "M-r" 'helm-eshell-history eshell-mode-map)))))

(defun eshell/init-esh-opt ()
  (use-package esh-opt
    :defer t))

(defun eshell/init-em-prompt ()
  (use-package em-prompt
    :defer t))

(defun eshell/init-em-term ()
  (use-package em-term
    :defer t
    :config
    (progn
      (add-to-list 'eshell-visual-commands "ssh")
      (add-to-list 'eshell-visual-commands "tail"))))

(defun eshell/init-em-cmpl ()
  (use-package em-cmpl
    :defer t))

(defun eshell/post-init-eshell ()
  (use-package eshell
    :defer t
    :init
    (progn

      (defalias 'esh 'eshell/eshell-here)
      (defalias 'eshell/e 'find-file)
      (defun eshell/l ()
        (eshell/ls "-al"))

      (defun eshell/cds ()
        "Change directory to the project's root."
        (eshell/cd (locate-dominating-file default-directory "src")))

      (defun eshell/cdl ()
        "Change directory to the project's root."
        (eshell/cd (locate-dominating-file default-directory "lib")))

      (defun eshell/cdg ()
        "Change directory to the project's root."
        (eshell/cd (locate-dominating-file default-directory ".git")))

      (when (not (functionp 'eshell/dfind))
        (defun eshell/dfind (dir &rest opts)
          (find-dired dir (mapconcat (lambda (arg)
                                       (if (get-text-property 0 'escaped arg)
                                           (concat "\"" arg "\"")
                                         arg))
                                     opts " "))))

      (when (not (functionp 'eshell/rgrep))
        (defun eshell/rgrep (&rest args)
          "Use Emacs grep facility instead of calling external grep."
          (eshell-grep "rgrep" args t)))

      (defun eshell/clear ()
        "04Dec2001 - sailor, to clear the eshell buffer."
        (interactive)
        (let ((inhibit-read-only t))
          (erase-buffer)))

      (defun eshell/gst () (magit-status default-directory))


      (defun eshell/eshell-here ()
        "Opens up a new shell in the directory associated with the
      current buffer's file. The eshell is renamed to match that
      directory to make multiple eshell windows easier."
        (interactive)
        (let* ((parent (if (buffer-file-name)
                           (file-name-directory (buffer-file-name))
                         default-directory))
               (dir-name (car (last (split-string parent "/" t))))
               (eshell-buffer-name (format "*eshell: %s*" dir-name))
               (buffer (eshell)))
          (with-current-buffer buffer
            (when parent
              (eshell/cd (list parent))
              (eshell-send-input))
            (end-of-buffer)
            (pop-to-buffer buffer)))))

    :config
    (progn

      (require 'esh-mode)
      (require 'esh-opt)
      (require 'em-prompt)
      (require 'em-term)
      (require 'em-cmpl)

      (setq-default eshell-cmpl-cycle-completions nil
                    eshell-save-history-on-exit t
                    eshell-buffer-shorthand t
                    eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'"
                    eshell-cmpl-ignore-case t)

      (setenv "PAGER" "cat")
      (setq eshell-cmpl-cycle-completions nil)
      (add-to-list 'eshell-command-completions-alist
                   '("gunzip" "gz\\'"))
      (add-to-list 'eshell-command-completions-alist
                   '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'"))

      (defface esk-eshell-error-prompt-face
        '((((class color) (background dark)) (:foreground "red" :bold t))
          (((class color) (background light)) (:foreground "red" :bold t)))
        "Face for nonzero prompt results"
        :group 'eshell-prompt)

      (add-hook 'eshell-after-prompt-hook
                (defun esk-eshell-exit-code-prompt-face ()
                  (when (and eshell-last-command-status
                             (not (zerop eshell-last-command-status)))
                    (let ((inhibit-read-only t))
                      (add-text-properties
                       (save-excursion (beginning-of-line) (point)) (point-max)
                       '(face esk-eshell-error-prompt-face))))))

      (add-hook 'eshell-mode-hook
                (defun eshell/no-company-please ()
                  (company-mode -1))))))

;; For each package, define a function eshell/init-<package-eshell>
;;
;; (defun eshell/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
