;; init-haskell.el - Setup emacs for editing haskell.

(req-package haskell-mode
  :require (flycheck flycheck-haskell)
  :commands haskell-mode
  :init
  (progn
    (autoload 'ghc-init "ghc" nil t))
  :config
  (progn
    (setq-default haskell-process-type 'cabal-repl
                  haskell-program-name "ghci -XTemplateHaskell")

    (evil-leader/set-key-for-mode 'haskell-mode
      "mt"  'haskell-process-do-type
      "mi"  'haskell-process-do-info
      "mu"  'haskell-mode-find-uses
      "mgg" 'haskell-mode-jump-to-def-or-tag
      "mf"  'haskell-mode-stylish-buffer
      "msb" 'haskell-process-load-or-reload
      "msc" 'haskell-interactive-mode-clear
      "mss" 'haskell-interactive-bring
      "msS" 'haskell-interactive-switch
      "mca" 'haskell-process-cabal
      "mcb" 'haskell-process-cabal-build
      "mcc" 'haskell-compile
      "mcv" 'haskell-cabal-visit-file
      "mhh" 'hoogle
      "mhy" 'hayoo
      "mhd" 'inferior-haskell-find-haddock
      "mdd" 'haskell-debug
      "mdb" 'haskell-debug/break-on-function
      "mdn" 'haskell-debug/next
      "mdN" 'haskell-debug/previous
      "mdB" 'haskell-debug/delete
      "mdc" 'haskell-debug/continue
      "mda" 'haskell-debug/abandon
      "mdr" 'haskell-debug/refresh
      "msS" 'haskell-interactive-switch
      "mC" 'haskell-compile
      "md" 'haskell-cabal-add-dependency
      "mb" 'haskell-cabal-goto-benchmark-section
      "me" 'haskell-cabal-goto-executable-section
      "mt" 'haskell-cabal-goto-test-suite-section
      "mm" 'haskell-cabal-goto-exposed-modules
      "ml" 'haskell-cabal-goto-library-section
      "mn" 'haskell-cabal-next-subsection
      "mp" 'haskell-cabal-previous-subsection
      "mN" 'haskell-cabal-next-section
      "mP" 'haskell-cabal-previous-section
      "mf" 'haskell-cabal-find-or-create-source-file)

    (mapcar (lambda (my-hook)
              (add-hook 'haskell-mode-hook my-hook))
            '(turn-on-haskell-indent
              turn-on-font-lock
              turn-on-eldoc-mode
              turn-on-haskell-doc-mode
              imenu-add-menubar-index
              interactive-haskell-mode
              (lambda () (setq evil-auto-indent nil))))

    (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
    (add-hook 'haskell-mode-hook
              (defun user-haskell/prep-ghc ()
                (condition-case err
                    (progn
                      (ghc-init))
                  (error
                   (message "ghc-mod not installed, install it with your system's package manager!")))))))

(provide 'init-haskell)
