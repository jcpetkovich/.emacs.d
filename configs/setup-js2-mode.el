(require 'setup-s)
(require 'setup-multiple-cursors)

(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-mode/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-refactor/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq-default js2-allow-rhino-new-expr-initializer nil)
(setq-default js2-auto-indent-p nil)
(setq-default js2-enter-indents-newline nil)
(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-indent-on-enter-key nil)
(setq-default js2-mirror-mode nil)
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-auto-indent-p t)
(setq-default js2-rebind-eol-bol-keys nil)
(setq-default js2-include-rhino-externs nil)
(setq-default js2-include-gears-externs nil)
(setq-default js2-concat-multiline-strings 'eol)

(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")

(require 'js2-imenu-extras)
(js2-imenu-extras-setup)

(eval-after-load "js2-mode"
  '(progn (define-key js2-mode-map
            (kbd "M-j") 'move-cursor-next-pane)))

(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'setup-js2-mode)
