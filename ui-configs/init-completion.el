;; =============================================================
;; Auto Complete
;; =============================================================

(require-package 'auto-complete)
(require 'auto-complete-config)
(require 'init-evil)

(setq ac-show-menu-timer 0.1
      ac-auto-show-menu t)

(add-hook 'flyspell-mode-hook
          (lambda ()
            (ac-flyspell-workaround)))

;;; Make sure autocomplete doesn't interfere with yasnippet.
(setq yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
(setq yas-after-exit-snippet-hook (lambda () (auto-complete-mode 1)))

;; =============================================================
;; Evil Keybindings
;; =============================================================

;; Navigation in autocomplete menues gets hijacked by evil
(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-p") 'ac-previous)

;; Let me stop autocompleting the emacs/evil way
(define-key ac-completing-map (kbd "C-g") 'ac-stop)
(define-key ac-completing-map (kbd "ESC") 'evil-normal-state)
(evil-make-intercept-map ac-completing-map)

(provide 'init-auto-complete)

;; =============================================================
;; Company Mode
;; =============================================================
(require-package 'company)
(require-package 'helm-company)
(require 'company)
(require 'init-evil)
(require 'init-auto-complete)

(define-key company-active-map (kbd "C-h") 'help-command)
(define-key company-active-map (kbd "C-w") 'kill-region-or-backward-word)
(define-key company-active-map (kbd "C-l") 'company-show-location)
(define-key company-active-map (kbd "M-1") nil)
(define-key company-active-map (kbd "M-2") nil)
(add-hook 'after-init-hook 'global-company-mode)

(setq-default company-idle-delay 0.3)

(defun use-auto-complete-instead ()
  (company-mode -1)
  (auto-complete-mode 1))

(add-hook 'ess-mode-hook 'use-auto-complete-instead)

(global-set-key (kbd "C-:") 'helm-company)

(provide 'init-company)

;; =============================================================
;; Hippie Expand
;; =============================================================

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol
                                         try-expand-whole-kill
                                         try-expand-line))

(defun hippie-expand-lines ()
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-expand-list
                                            try-expand-list-all-buffers
                                            try-expand-line
                                            try-expand-line-all-buffers)))
    (hippie-expand nil)))

(defadvice he-substitute-string (after he-paredit-fix activate)
  "remove extra paren when expanding line in paredit"
  (if (and paredit-mode (equal (substring str -1) ")"))
      (progn (backward-delete-char 1) (forward-char))))

(provide 'init-hippie-expand)

;; =============================================================
;; yasnippet
;; =============================================================
(require-package 'yasnippet)
(require-package 'buster-snippets)
(require 'snippet-helpers)

;;; Use only my own snippets
(setq yas-snippet-dirs `(,(expand-file-name (concat user-emacs-directory "snippets"))))

(yas-global-mode 1)
(global-set-key (kbd "C-x y") 'yas/insert-snippet)

;;; Sometimes with certain more complex snippets, evil can choke
;;; trying to get back to normal-mode
(add-hook 'yas-after-exit-snippet-hook
          (lambda () (setq evil-current-insertion nil)))

(provide 'init-yasnippet)
