;; init-python.el - Setup emacs for editing python.

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

    (bind-keys :map python-mode-map
               ("M-." . jedi:goto-definition)
               ("M-," . jedi:goto-definition-pop-marker)
               ("<backspace>" . user-python/smart-delete))

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
