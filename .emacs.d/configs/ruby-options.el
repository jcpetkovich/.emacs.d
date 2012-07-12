;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(setq rsense-home (expand-file-name "~/src/ruby/rsense-0.3"))
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


(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook (lambda () (ruby-block-mode t)))
(add-hook 'ruby-mode-hook 'auto-complete-mode)

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (define-key nxhtml-mode-map  (kbd "\C-c\C-r") 'open-ruby-section)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "\C-c\C-c") 'xmp)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "M-<tab>") 'ac-complete-rsense)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key [f1] 'yari)))

;; ============================================================= 
;; Viper Keybindings
;; ============================================================= 
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (vimpulse-local-set-key 'visual-state (kbd "<tab>") 'indent-for-tab-command)))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (vimpulse-local-set-key 'vi-state (kbd "{") 'ruby-beginning-of-block)))

;; (add-hook 'ruby-mode-hook 
;;           (lambda ()
;;             (vimpulse-local-set-key 'vi-state (kbd "}") 'ruby-end-of-block)))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'normal ruby-mode-map
                       (kbd "{") 'ruby-beginning-of-block
                       (kbd "}") 'ruby-end-of-block)
     (evil-declare-key 'visual ruby-mode-map
                       (kbd "<tab>") 'indent-for-tab-command)))


(setq rsense-rurema-home "~/.ruby-reference-manual")


(mapcar (lambda (keyword)
          (font-lock-add-keywords
           'ruby-mode
           `((,(concat ".\\(" keyword "\\)\\_>") 1 font-lock-keyword-face))))
        (list "each" "collect" "reject" "select" "inject" "include" "map" "reduce"))


;; any?
;; chunk
;; collect
;; collect_concat
;; count
;; cycle
;; detect
;; drop
;; drop_while
;; each_cons
;; each_entry
;; each_slice
;; each_with_index
;; each_with_object
;; entries
;; find
;; find_all
;; find_index
;; first
;; flat_map
;; grep
;; group_by
;; include?
;; inject
;; map
;; max
;; max_by
;; member?
;; min
;; min_by
;; minmax
;; minmax_by
;; none?
;; one?
;; partition
;; reduce
;; reject
;; reverse_each
;; select
;; slice_before
;; sort
;; sort_by
;; take
;; take_while
;; to_a
;; to_json
;; zip

