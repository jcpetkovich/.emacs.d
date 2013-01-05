;; =============================================================
;; Load Path
;; =============================================================
(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme")
(add-to-list 'load-path "/home/jcp/jc-personal/site-lisp")
(add-to-list 'load-path "/usr/lib64/chicken/5")

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq-default indent-tabs-mode nil)     ;Tabs as spaces
(setq org-hide-leading-stars     t
      org-odd-levels-only        t
      inhibit-splash-screen      t
      lpr-command                "xpp" ; Add support for gui printing in linux
      display-time-day-and-date  t
      display-time-24hr-format   t
      backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups"))))
      vc-make-backup-files t)

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
(require 'etags-update)

;; =============================================================
;; Winner Mode
;; =============================================================
(winner-mode 1)

;; =============================================================
;; Color Theme
;; =============================================================

;; (load-theme 'solarized-dark t)
(load "solarized-dark-theme")
;; (require 'solarized)
;; (eval-after-load "init"
;;   '(progn
;;      (deftheme solarized-light "The light variant of the Solarized colour theme")
;;      (deftheme solarized-dark "The dark variant of the Solarized colour theme")
;;      (defun light ()
;;        (interactive)
;;        (create-solarized-theme 'light 'solarized-light))
;;      (defun dark ()
;;        (interactive)
;;        (create-solarized-theme 'dark 'solarized-dark))
;;      (dark)))

;; =============================================================
;; Evil Mode
;; =============================================================
(setq evil-want-C-i-jump nil)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
