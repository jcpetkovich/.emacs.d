;; init-cosmetic.el - Configure cosmetic emacs settings.

;; =============================================================
;; Custom Set Variables
;; =============================================================

(setq-default
 mouse-wheel-scroll-amount '(1)
 scroll-conservatively     100000
 show-paren-style          'expression
 inhibit-splash-screen     t
 display-time-day-and-date nil
 display-time-24hr-format  nil)

;;; Make the frame title easy to search for among open windows
(setq-default frame-title-format
              (list
               '(:eval (if buffer-file-name (buffer-file-name) (buffer-name)))))

;;; No decorations please
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; Display time
(display-time)

;; =============================================================
;; Parenface
;; =============================================================
(req-package parenface)
(show-paren-mode 1)

;; =============================================================
;; Color Theme
;; =============================================================

(defvar cosmetic/hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

(defun cosmetic/hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil cosmetic/hexcolour-keywords))

(req-package smart-mode-line
  :commands sml/setup
  :config
  (progn
    (setq-default rm-blacklist '(" SliNav" " yas" " ElDoc" " Undo-Tree"
                                 " AC" " Ref" " OrgTbl" " Doc" " Ind" " WSC"
                                 " Projectile" " Helm" " company"))

    (setq sml/replacer-regexp-list nil)
    (--each '(("^~/jc-public/projects/" ":Proj:")
              ("^~/src/linux-trees/" ":Linux:")
              ("^~/jc-public/projects/eval-lab/" ":DataMill:"))
      (push it sml/replacer-regexp-list))))

(req-package moe-theme
  :defer t
  :init
  (progn
    (defun cosmetic/dark ()
      (interactive)
      (load-theme 'moe-dark t)
      (sml/setup)
      (sml/apply-theme 'dark))

    (defun cosmetic/light ()
      (interactive)
      (load-theme 'moe-light t)
      (sml/setup)
      (sml/apply-theme 'light))

    (defun cosmetic/install-theme ()
      (require 'moe-theme)
      (cosmetic/dark))

    (add-hook 'after-init-hook 'cosmetic/install-theme)))

;; =============================================================
;; Line numbers
;; =============================================================
(req-package nlinum
  :commands global-nlinum-mode
  :idle (global-nlinum-mode)
  :config
  (progn
    (defun nlinum--face-height (face)
      (condition-case err
          (aref (font-info (face-font face)) 2)
        (error (message "Unable to get font at this time.") 0)))

    (defun cosmetic/disable-line-numbers ()
      (nlinum-mode -1))

    (add-hook 'rcirc-mode-hook 'cosmetic/disable-line-numbers)))

;; =============================================================
;; Diminish
;; =============================================================

(req-package diminish
  :init
  (progn
    (defun cosmetic/diminish-major (mode new-string)
      "Diminish the major mode. It will only diminish the major mode
such that the string is shorter, not so that it does not appear
at all like the regular `diminish' function. It uses
lexical-binding to create a proper closure."

      (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
        (eval `(add-hook ',mode-hook (lambda () (setq mode-name ,new-string)))))))

  :idle
  (progn
    (eval-after-load "paredit"
      '(diminish 'paredit-mode "p()"))

    (eval-after-load "smartparens"
      '(diminish 'smartparens-mode "s()"))

    (eval-after-load "flyspell"
      '(diminish 'flyspell-mode " FS"))

    (cosmetic/diminish-major 'emacs-lisp-mode "Elisp")))

(provide 'init-cosmetic)
