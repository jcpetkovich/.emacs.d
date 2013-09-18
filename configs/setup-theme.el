;; =============================================================
;; Load Path
;; =============================================================
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "site-lisp/emacs-color-theme-solarized"))

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq-default indent-tabs-mode nil      ;Tabs as spaces by default
              save-place t)

(setq org-hide-leading-stars     t
      org-odd-levels-only        t
      inhibit-splash-screen      t
      lpr-command                "xpp" ; Add support for gui printing in linux
      display-time-day-and-date  t
      display-time-24hr-format   t
      backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups"))))
      vc-make-backup-files t
      save-interprogram-paste-before-kill t
      save-place-file (concat user-emacs-directory "places")
      mouse-wheel-scroll-amount '(1))

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
(require 'ido) ; ido-mode for better buffer switching and file finding, C-f to return to normal style
(require 'uniquify)
(require 'saveplace)

;; =============================================================
;; Winner Mode
;; =============================================================
(winner-mode 1)


;; =============================================================
;; Color Theme
;; =============================================================

(defun dark ()
  (interactive)
  (load-theme 'solarized-dark t))

(defun light ()
  (interactive)
  (load-theme 'solarized-light t))

(dark)

;; (custom-theme-set-faces
;;  'solarized-light
;;  `(comint-highlight-prompt ((t (:foreground "#268bd2"))))
;;  `(font-lock-keyword-face ((((class color) (min-colors 89)) (:foreground "#859900" :weight bold)))))

;; =============================================================
;; Evil Mode
;; =============================================================

(eval-after-load "init"
  ;; Evil (the version I'm using) is finicky about the existance of
  ;; the following variables before it's loaded, and evil as a whole
  ;; must be loaded only after everything else has been loaded.
  '(progn
     (setq evil-want-C-i-jump nil)
     (setq evil-want-C-u-scroll t)
     (require 'evil)
     (evil-mode 1)))

(provide 'setup-theme)
