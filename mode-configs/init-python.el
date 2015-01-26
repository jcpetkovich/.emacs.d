;; init-python.el - Setup emacs for editing python.

(req-package virtualenvwrapper
  :require (python evil-leader)
  :config
  (progn
    (venv-initialize-interactive-shells)
    (venv-initialize-eshell)
    (setq-default venv-location '("~/.virtualenvs/"))
    (evil-leader/set-key-for-mode 'python-mode "mv" 'pyvenv-workon)
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

(req-package nose
  :require (python evil-leader)
  :init
  (evil-leader/set-key-for-mode 'python-mode
    "mTa" 'nosetests-pdb-all
    "mta" 'nosetests-all
    "mTb" 'nosetests-pdb-module
    "mtb" 'nosetests-module
    "mTt" 'nosetests-pdb-one
    "mtt" 'nosetests-one
    "mTm" 'nosetests-pdb-module
    "mtm" 'nosetests-module
    "mTs" 'nosetests-pdb-suite
    "mts" 'nosetests-suite))

(req-package python
  :require (evil evil-leader)
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

    (bind-keys :map python-mode-map
               ("M-." . jedi:goto-definition)
               ("M-," . jedi:goto-definition-pop-marker)
               ("<backspace>" . user-python/smart-delete)
               ("<f6>" . nosetests-one))


    (evil-leader/set-key-for-mode 'python-mode
      "mB"  'python-shell-send-buffer-switch
      "mb"  'python-shell-send-buffer
      "mdb" 'python-toggle-breakpoint
      "mF"  'python-shell-send-defun-switch
      "mf"  'python-shell-send-defun
      "mi"  'python-start-or-switch-repl
      "mR"  'python-shell-send-region-switch
      "mr"  'python-shell-send-region)

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
