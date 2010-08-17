(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(defun open-ruby-section ()
  "Insert <p></p> at cursor point."
  (interactive)
  (insert "<%  %>")
  (backward-char 3))

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (viper-add-local-keys 'insert-state '(("\C-c\C-r" . open-ruby-section)))))
