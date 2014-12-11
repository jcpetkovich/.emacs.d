;; init-python.el - Setup emacs for editing python.

(req-package virtualenvwrapper
  :require python
  :config
  (progn
    (venv-initialize-interactive-shells)
    (venv-initialize-eshell)
    (setq-default venv-location '("~/.virtualenvs/"))
    (add-hook 'python-mode-hook
              (defun user-python/find-virtualenv ()
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
                      (set (make-local-variable 'venv-location) (-concat venv-location current-venv)))))))))

(req-package jedi
  :require python
  :init (add-hook 'python-mode-hook 'jedi:setup)
  :config
  (progn
    (setq-default jedi:setup-keys t
                  jedi:complete-on-dot t)))

(req-package ein
  :require python)

(req-package python
  :require evil
  :commands python-mode
  :config
  (progn

    (defun user-python/smart-delete ()
      (interactive)
      (let ((valid-pairs (sp--get-pair-list)))
        (if (--any-p
             (sp--looking-back (sp--strict-regexp-quote (cdr it)))
             valid-pairs)
            (sp-backward-delete-char)
          (call-interactively 'python-indent-dedent-line-backspace))))

    (defun user-python/get-current-class ()
      (interactive)
      (save-excursion
        (catch 'result
          (let ((class-regexp "\\s-*class")
                start end definition last-point-pos)
            (while (and (not (looking-at class-regexp))
                        (not (equalp (point) last-point-pos)))
              (setq last-point-pos (point))
              (python-nav-backward-up-list))

            (when (not (looking-at class-regexp))
              (message "didn't find a class")
              (throw 'result ""))

            (beginning-of-line)
            (setq start (point))
            (end-of-line)
            (setq end (point))
            (setq definition (buffer-substring-no-properties start end))
            (setq definition (nth 1 (s-match python-nav-beginning-of-defun-regexp definition)))))))

    (defun user-python/get-current-test ()
      (interactive)
      (save-excursion
        (catch 'result
          (let ((function-regexp "\\s-*def")
                start end definition last-point-pos)
            (while (and (not (looking-at function-regexp))
                        (not (equalp (point) last-point-pos)))
              (setq last-point-pos (point))
              (python-nav-backward-up-list))

            (when (not (looking-at function-regexp))
              (message "didn't find a function")
              (throw 'result ""))

            (beginning-of-line)
            (setq start (point))
            (end-of-line)
            (setq end (point))
            (setq definition (buffer-substring-no-properties start end))
            (setq definition (nth 1 (s-match python-nav-beginning-of-defun-regexp definition)))))))

    (defun user-python/nosetests-cmd-by-context ()
      (interactive)
      (save-excursion
        (let* ((current-root (projectile-project-root))
               (test-name (user-python/get-current-test))
               (class-name (user-python/get-current-class))
               (file-name (s-chop-prefix current-root (buffer-file-name)))
               (test-command (concat
                              "nosetests "
                              file-name
                              (if class-name
                                  (concat  ":" class-name
                                           (if test-name
                                               (concat "." test-name)))))))
          test-command)))

    (defun user-python/nosetests-by-context ()
      (interactive)
      (if (not (projectile-project-p))
          (message "Not in project")
        (let ((compilation-cmd (user-python/nosetests-cmd-by-context))
              (default-directory (projectile-project-root)))
          (compilation-start compilation-cmd))))


    (bind-keys :map python-mode-map
               ("M-." . jedi:goto-definition)
               ("M-," . jedi:goto-definition-pop-marker)
               ("<backspace>" . user-python/smart-delete)
               ("<f6>" . user-python/nosetests-by-context))

    ;; Fix evil bindings
    (-each '(normal insert)
      (lambda (mode) (evil-declare-key mode python-mode-map
                       (kbd "M-.") 'jedi:goto-definition
                       (kbd "M-,") 'jedi:goto-definition-pop-marker)))

    (setq-default gud-pdb-command-name "python -m pdb")

    (add-hook 'python-mode-hook 'completion/use-auto-complete-instead)

    ;; When ipython is available, prefer it.
    (when (executable-find "ipython")
      (setq-default python-shell-interpreter "ipython"
                    python-shell-interpreter-args ""
                    python-shell-prompt-regexp "In \\[[0-9]+\\]: "
                    python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
                    python-shell-completion-setup-code
                    "from IPython.core.completerlib import module_completion"
                    python-shell-completion-module-string-code
                    "';'.join(module_completion('''%s'''))\n"
                    python-shell-completion-string-code
                    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))))

(provide 'init-python)
