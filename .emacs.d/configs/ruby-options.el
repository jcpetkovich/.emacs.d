(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(defun open-ruby-section ()
  "Insert <p></p> at cursor point."
  (interactive)
  (insert "<%  %>")
  (backward-char 3))

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (define-key nxhtml-mode-map  (kbd "\C-c\C-r") 'open-ruby-section)))

(require 'rcodetools)
(describe-function 'xmp)
(describe-function 'comment-dwim)
(describe-function 'rct-complete-symbol)

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "\C-c\C-c\C-c") 'xmp)))
