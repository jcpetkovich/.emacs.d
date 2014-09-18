;; ;;; Code:

(require-package 'haskell-mode)
(require-package 'flycheck-haskell)
(require 'haskell-mode-autoloads)
(autoload 'ghc-init "ghc" nil t)

(setq haskell-process-type 'cabal-repl)
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
          (lambda ()
            (condition-case err
                (progn
                  (ghc-init))
              (error
               (message "ghc-mod not installed, install it with your system's package manager!")))))

(provide 'init-haskell)
