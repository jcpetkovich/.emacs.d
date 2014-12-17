;; init-ruby.el - Setup emacs for editing ruby.

(req-package ruby-test-mode
  :require ruby-mode)

(req-package inf-ruby
  :require ruby-mode)

(req-package company-inf-ruby
  :require inf-ruby)

(req-package robe
  :require ruby-mode
  :init (add-hook 'ruby-mode-hook 'robe-mode)
  :config
  (progn
    (add-to-list 'company-backends 'company-robe)))

(req-package yari
  :require ruby-mode)

(req-package ruby-mode
  :commands ruby-mode
  :config
  (progn
    (defun open-ruby-section ()
      "Insert <p></p> at cursor point."
      (interactive)
      (insert "<%  %>")
      (backward-char 3))

    (defun ruby-insert-end ()
      (interactive)
      (insert "end")
      (ruby-indent-line t)
      (end-of-line))

    (bind-key "C-c C-e" 'ruby-insert-end ruby-mode-map)

    (evil-declare-key 'normal ruby-mode-map
      (kbd "{") 'ruby-beginning-of-block
      (kbd "}") 'ruby-end-of-block)
    (evil-declare-key 'visual ruby-mode-map
      (kbd "<tab>") 'indent-for-tab-command)

    ;; Highlight basic array looping functions, since they are used more
    ;; than most keywords
    (mapcar (lambda (keyword)
              (font-lock-add-keywords
               'ruby-mode
               `((,(concat ".\\(" keyword "\\)\\_>") 1 font-lock-keyword-face))))
            (list "each" "collect" "reject" "select" "inject" "include" "map" "reduce"))))

(provide 'init-ruby)
