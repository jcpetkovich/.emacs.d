;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(setq rsense-home (expand-file-name "~/src/ruby/rsense-0.3"))
(setq rsense-rurema-home "~/.ruby-reference-manual")

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

(require 'ruby-block)
(require 'flymake-ruby)

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (define-key nxhtml-mode-map  (kbd "\C-c\C-r") 'open-ruby-section)))

(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook 'auto-complete-mode)

(add-hook 'ruby-mode-hook
          (lambda ()
            (ruby-block-mode t)
            (define-key ruby-mode-map (kbd "\C-c\C-c") 'xmp)
            (define-key ruby-mode-map (kbd "M-<tab>") 'ac-complete-rsense)
            (define-key ruby-mode-map [f1] 'yari)))

;; ============================================================= 
;; Evil Keybindings
;; ============================================================= 
(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal ruby-mode-map
                       (kbd "{") 'ruby-beginning-of-block
                       (kbd "}") 'ruby-end-of-block)
     (evil-declare-key 'visual ruby-mode-map
                       (kbd "<tab>") 'indent-for-tab-command)))

;;; Highlight basic array looping functions, since they are used more
;;; than most keywords
(mapcar (lambda (keyword)
          (font-lock-add-keywords
           'ruby-mode
           `((,(concat ".\\(" keyword "\\)\\_>") 1 font-lock-keyword-face))))
        (list "each" "collect" "reject" "select" "inject" "include" "map" "reduce"))

