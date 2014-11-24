;; init-shell.el - Configure shells.

;; =============================================================
;; Eshell
;; =============================================================
(req-package eshell
  :require (esh-opt em-prompt em-term em-cmpl)
  :defer t
  :init
  (progn

    (defalias 'esh 'user-eshell/eshell-here)

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


    (defun user-eshell/eshell-here ()
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

    (bind-key "C-c r" 'helm-eshell-history eshell-mode-map)

    (setq-default eshell-cmpl-cycle-completions nil
                  eshell-save-history-on-exit t
                  eshell-buffer-shorthand t
                  eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'"
                  eshell-cmpl-ignore-case t)

    (setenv "PAGER" "cat")
    (setq eshell-cmpl-cycle-completions nil)
    (add-to-list 'eshell-visual-commands "ssh")
    (add-to-list 'eshell-visual-commands "tail")
    (add-to-list 'eshell-command-completions-alist
                 '("gunzip" "gz\\'"))
    (add-to-list 'eshell-command-completions-alist
                 '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'"))

    ;; Plan 9 shell please.
    (require 'em-smart)

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
                     '(face esk-eshell-error-prompt-face))))))))

;; =============================================================
;; Term
;; =============================================================
(req-package term
  :require (evil yasnippet)
  :config
  (progn
    (add-to-list 'evil-emacs-state-modes 'term-mode)
    (add-hook 'term-mode-hook (lambda () (yas-minor-mode -1)))))

(provide 'init-shell)
