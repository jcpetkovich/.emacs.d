(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(setq rsense-home "/home/jcp/src/ruby/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))

(defun open-ruby-section ()
  "Insert <p></p> at cursor point."
  (interactive)
  (insert "<%  %>")
  (backward-char 3))

(require 'rcodetools)
(require 'icicles-rcodetools)
(require 'inf-ruby-bond)
(require 'rsense)
(describe-function 'xmp)
(describe-function 'comment-dwim)

(add-hook 'ruby-mode-hook 'auto-complete-mode)

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (define-key nxhtml-mode-map  (kbd "\C-c\C-r") 'open-ruby-section)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "\C-c\C-c\C-c") 'xmp)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (vimpulse-local-set-key 'visual-state (kbd "<tab>") 'indent-for-tab-command)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (vimpulse-local-set-key 'vi-state (kbd "{") 'ruby-beginning-of-block)))

(add-hook 'ruby-mode-hook 
          (lambda ()
            (vimpulse-local-set-key 'vi-state (kbd "}") 'ruby-end-of-block)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "M-<tab>") 'ac-complete-rsense)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key [f1] 'yari)))

(setq rsense-rurema-home "~/.ruby-reference-manual")


