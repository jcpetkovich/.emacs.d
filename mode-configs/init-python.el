
(require-package 'jedi)
(require-package 'ein)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;;; pdb
(setq gud-pdb-command-name "python -m pdb")

(add-hook 'python-mode-hook
          (lambda ()
            (-each '(normal insert)
                   (lambda (mode) (evil-declare-key mode python-mode-map
                                    (kbd "M-.") 'jedi:goto-definition
                                    (kbd "M-,") 'jedi:goto-definition-pop-marker)))))

;;; When ipython is available, prefer it.
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args ""
        python-shell-prompt-regexp "In \\[[0-9]+\\]: "
        python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
        python-shell-completion-setup-code
        "from IPython.core.completerlib import module_completion"
        python-shell-completion-module-string-code
        "';'.join(module_completion('''%s'''))\n"
        python-shell-completion-string-code
        "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))

(provide 'init-python)
