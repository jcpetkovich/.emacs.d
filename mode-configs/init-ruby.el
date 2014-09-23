
(require-package 'inf-ruby)
(require-package 'robe)
(require 'init-evil)
(require 'init-company)

(add-hook 'ruby-mode-hook 'robe-mode)

(add-to-list 'company-backends 'company-robe)

;;; Use my patched ruby-mode
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/inf-ruby-bond")))
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/ruby-mode")))
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/yari")))

(require 'ruby-mode)
(require 'inf-ruby-bond)

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

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-insert-end)))

;; =============================================================
;; Evil Keybindings
;; =============================================================
(evil-declare-key 'normal ruby-mode-map
  (kbd "{") 'ruby-beginning-of-block
  (kbd "}") 'ruby-end-of-block)
(evil-declare-key 'visual ruby-mode-map
  (kbd "<tab>") 'indent-for-tab-command)

;;; Highlight basic array looping functions, since they are used more
;;; than most keywords
(mapcar (lambda (keyword)
          (font-lock-add-keywords
           'ruby-mode
           `((,(concat ".\\(" keyword "\\)\\_>") 1 font-lock-keyword-face))))
        (list "each" "collect" "reject" "select" "inject" "include" "map" "reduce"))

(provide 'init-ruby)