;;; packages.el --- python-extras Layer packages File for Spacemacs
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

(setq python-extras-packages
      '(
        virtualenvwrapper

        (python :location built-in)
        )
      )

(setq python-extras-excluded-packages '())

(defun python-extras/init-virtualenvwrapper ()
  (use-package projectile
    :defer t
    :commands projectile-project-p)
  (use-package virtualenvwrapper
    :init
    (progn
      (defvar python-extras/enabled nil)

      (evil-leader/set-key-for-mode 'python-mode
        "mV" 'venv-workon
        "mga" 'anaconda-mode-goto-assignments)

      (add-hook 'python-mode-hook
                (defun python-extras/find-virtualenv ()
                  (when (not python-extras/enabled)
                    (setq python-extras/enabled t)

                    (venv-initialize-interactive-shells)
                    (venv-initialize-eshell)
                    (setq-default venv-location "~/.virtualenvs/"))

                  (when buffer-file-name  ; Check that the buffer has a file
                    (when (projectile-project-p)
                      (let* ((default-venv-directories
                               (--filter
                                (and
                                 (not (s-equals-p "" it))
                                 (file-directory-p it))
                                (-map
                                 's-trim
                                 (s-split "\n"
                                          (shell-command-to-string
                                           (concat "find " (projectile-project-root) " -name dev-python -type d"))))))
                             (current-venv
                              (--filter (s-match (s-chop-suffix "dev-python" it) buffer-file-name)
                                        default-venv-directories)))
                        (set (make-local-variable 'venv-location) current-venv)))))))))

(defun python-extras/post-init-python ()
  (use-package python
    :config
    (progn
      (defadvice python-shell-send-region (after python-shell-send-region-toggle-mark activate)
        (deactivate-mark))
      (defun python-extras/smart-delete ()
        (interactive)
        (let ((valid-pairs (sp--get-pair-list)))
          (if (--any-p
               (sp--looking-back (sp--strict-regexp-quote (cdr it)))
               valid-pairs)
              (sp-backward-delete-char)
            (call-interactively 'python-indent-dedent-line-backspace))))

      (setq flycheck-flake8rc "~/.config/flake8")
      (bind-key "<backspace>" 'python-extras/smart-delete python-mode-map))))
