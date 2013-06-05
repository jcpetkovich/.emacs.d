;; ;;; Code:

(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")

(load "haskell-site-file")

(mapcar (lambda (my-hook)
          (add-hook 'haskell-mode-hook my-hook))
        '(turn-on-haskell-indent
          turn-on-font-lock
          turn-on-eldoc-mode
          turn-on-haskell-doc-mode
          imenu-add-menubar-index
          (lambda () (setq evil-auto-indent nil))))


(add-hook 'haskell-mode-hook
          (lambda ()
            (condition-case err
                (ghc-init)
              (error
               (message "ghc-mod not installed, install it with your system's package manager!")))))

;;; Less silly ghc-save-buffer
(defun ghc-save-buffer ()
  (interactive)
  (if (buffer-modified-p)
      (call-interactively 'save-buffer))
  (flymake-start-syntax-check))

(provide 'setup-haskell)
