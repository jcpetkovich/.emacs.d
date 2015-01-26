;; init-go.el - Setup emacs for editing go code.

(req-package go-mode
  :require evil-leader
  :config
  (progn
    (--each '(normal insert)
      (evil-declare-key it go-mode-map
        (kbd "M-.") 'godef-jump))

    (evil-leader/set-key-for-mode 'go-mode
      "moo" 'go-oracle-set-scope
      "mo<" 'go-oracle-callers
      "mo>" 'go-oracle-callees
      "moc" 'go-oracle-peers
      "mod" 'go-oracle-definition
      "mof" 'go-oracle-freevars
      "mog" 'go-oracle-callgraph
      "moi" 'go-oracle-implements
      "mop" 'go-oracle-pointsto
      "mor" 'go-oracle-referrers
      "mos" 'go-oracle-callstack
      "mot" 'go-oracle-describe
      "mdp"  'godoc-at-point
      "mig"  'go-goto-imports
      "mia"  'go-import-add
      "mir"  'go-remove-unused-imports
      "mpb"  'go-play-buffer
      "mpr"  'go-play-region
      "mpd"  'go-download-play
      "mgg"   'godef-jump)

    (bind-keys :map go-mode-map
               ("M-," . pop-tag-mark)
               ("M-." . godef-jump)
               ("C-c C-d" . godoc-at-point))
    (add-hook 'before-save-hook 'gofmt-before-save)

    (add-hook 'go-mode-hook
              (defun user-go/setup-compile ()
                (if (not (string-match "go" compile-command))
                    (set (make-local-variable 'compile-command)
                         "go build -v && go test -v && go vet"))))))

(req-package company-go
  :require go-mode)

(req-package go-eldoc
  :require go-mode
  :config (add-hook 'go-mode-hook 'go-eldoc-setup))
