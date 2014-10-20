;; init-completion.el - Setup all completion methods.

;; =============================================================
;; Auto Complete
;; =============================================================
(req-package auto-complete
  :require (evil company)
  :commands auto-complete-mode
  :config
  (progn
    (require 'auto-complete-config)

    ;; =============================================================
    ;; Evil Keybindings
    ;; =============================================================

    ;; Navigation in autocomplete menues gets hijacked by evil
    (bind-keys :map ac-completing-map
               ("C-n" . ac-next)
               ("C-p" . ac-previous)
               ("C-g" . ac-stop)
               ("ESC" . evil-normal-state))

    ;; Let me stop autocompleting the emacs/evil way
    (evil-make-intercept-map ac-completing-map)

    (setq-default ac-show-menu-timer 0.1
                  ac-auto-show-menu t
                  ac-ignore-case nil)

    (defun completion/ac-flyspell-workaround ()
      (if auto-complete-mode
          (ac-flyspell-workaround)))

    (add-hook 'flyspell-mode-hook 'completion/ac-flyspell-workaround)

    (defvar completion/yas-ac-was-on nil
      "This tells `yasnippet' if auto-complete should be on for
      the current mode.")

    (defun completion/yas-ac-expand-workaround ()
      "Disable auto-complete-mode during yas expansion, but only
      if it was enabled in the first place."
      (when auto-complete-mode
        (setf (make-local-variable completion/yas-ac-was-on) t)
        (auto-complete-mode -1)))

    (defun completion/yas-ac-exit-workaround ()
      "Re-enable auto-complete-mode if it was enabled previously
      in this mode."
      (when completion/yas-ac-was-on
        (setf completion/yas-ac-was-on nil)
        (auto-complete-mode 1)))

    (eval-after-load "yasnippet"
      '(progn
         (add-hook 'yas-before-expand-snippet-hook 'completion/yas-ac-expand-workaround)
         (add-hook 'yas-after-exit-snippet-hook 'completion/yas-ac-exit-workaround)))

    (defun completion/use-auto-complete-instead ()
      (company-mode -1)
      (auto-complete-mode 1))))

;; =============================================================
;; Company Mode
;; =============================================================
(req-package company
  :require (evil)
  :commands global-company-mode
  :init
  (progn
    (add-hook 'after-init-hook 'global-company-mode))

  :config
  (progn
    (bind-keys :map company-active-map
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous)
               ("C-h" . help-command)
               ("C-w" . user-utils/kill-region-or-backward-word)
               ("C-l" . company-show-location)
               ("M-1" . nil)
               ("M-2" . nil))

    (evil-make-intercept-map company-active-map)

    (setq-default company-idle-delay 0.3)))

;; =============================================================
;; Hippie Expand
;; =============================================================
(req-package hippie-exp
  :bind (("M-/" . hippie-expand)
         ("M-?" . hippie-expand-lines))
  :init
  (progn
    (defun hippie-expand-lines ()
      (interactive)
      (let ((hippie-expand-try-functions-list '(try-expand-list
                                                try-expand-list-all-buffers
                                                try-expand-line
                                                try-expand-line-all-buffers)))
        (hippie-expand nil))))

  :config
  (progn
    (setq-default hippie-expand-dabbrev-skip-space t
                  hippie-expand-try-functions-list
                  '(try-expand-dabbrev
                    try-expand-dabbrev-all-buffers
                    try-expand-dabbrev-from-kill
                    try-complete-file-name-partially
                    try-complete-file-name
                    try-expand-all-abbrevs
                    try-complete-lisp-symbol-partially
                    try-complete-lisp-symbol
                    try-expand-whole-kill
                    try-expand-line))

    (defadvice he-substitute-string (after completion/he-paredit-fix activate)
      "remove extra paren when expanding line in paredit"
      (if (and paredit-mode (equal (substring str -1) ")"))
          (progn (backward-delete-char 1) (forward-char))))))

;; =============================================================
;; yasnippet
;; =============================================================
(req-package yasnippet
  :commands yas/insert-snippet
  :defer t
  :init
  (progn
    (setq-default yas-snippet-dirs `(,(expand-file-name (concat user-emacs-directory "snippets")))
                  yas-indent-line 'auto))

  :config
  (progn
    (yas-global-mode 1)
    ;; Sometimes with certain more complex snippets, evil can choke
    ;; trying to get back to normal-mode
    (defun completion/yas-evil-workaround ()
      (setq evil-current-insertion nil))

    (add-hook 'yas-after-exit-snippet-hook 'completion/yas-evil-workaround)))

(provide 'init-completion)
