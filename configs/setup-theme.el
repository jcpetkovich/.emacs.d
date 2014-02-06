
;; =============================================================
;; Load Path
;; =============================================================

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq-default indent-tabs-mode nil      ;Tabs as spaces by default
              save-place t)

(setq inhibit-splash-screen      t
      lpr-command                "xpp" ; Add support for gui printing in linux
      display-time-day-and-date  nil
      display-time-24hr-format   nil
      backup-directory-alist
      `((".*" . ,(expand-file-name
                  (concat user-emacs-directory "backups"))))
      vc-make-backup-files t
      save-interprogram-paste-before-kill t
      save-place-file (concat user-emacs-directory "places")
      mouse-wheel-scroll-amount '(1)
      show-paren-style 'expression)

;;; Make the frame title easy to search for among open windows
(setq frame-title-format '("emacs: " buffer-file-name "%f" ("%b")))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


;; =============================================================
;; Custom Set Functions
;; =============================================================
(fset 'yes-or-no-p 'y-or-n-p)        ; Make acknowledging stuff faster

;; =============================================================
;; Mode Toggling
;; =============================================================
(display-time)

;; =============================================================
;; Require Statements - that dont fit elsewhere
;; =============================================================
(require 'cl)
(require 'uniquify)
(require 'saveplace)

;; =============================================================
;; Winner Mode
;; =============================================================
(winner-mode 1)

;; =============================================================
;; Color Theme
;; =============================================================

(require-package 'smart-mode-line)
(require-package 'moe-theme)

(defun dark ()
  (interactive)
  (load-theme 'moe-dark t)
  (sml/setup)
  (sml/apply-theme 'dark))

(defun light ()
  (interactive)
  (load-theme 'moe-light t)
  (sml/setup)
  (sml/apply-theme 'light))

(dark)

(setq-default sml/hidden-modes '(" SliNav" " yas" " ElDoc" " Undo-Tree"
                                 " AC" " Ref" " OrgTbl" " Doc" " Ind" " WSC"))

(--each '(("^~/jc-public/projects/" ":Proj:")
          ("^~/src/linux-trees/" ":Linux:")
          ("^~/jc-public/projects/eval-lab/" ":DataMill:"))
  (push it sml/replacer-regexp-list))


(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

;; =============================================================
;; Evil Mode
;; =============================================================


(add-hook 'after-init-hook
          (lambda ()
            ;; Evil (the version I'm using) is finicky about the existance of
            ;; the following variables before it's loaded, and evil as a whole
            ;; must be loaded only after everything else has been loaded.
            (setq evil-want-C-i-jump nil)
            (setq evil-want-C-u-scroll t)
            (require 'evil)
            (evil-mode 1)))

(provide 'setup-theme)
