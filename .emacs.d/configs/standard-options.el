;; ============================================================= 
;; Load Path
;; ============================================================= 
(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme")
(add-to-list 'load-path "/home/jcp/jc-personal/site-lisp")
(add-to-list 'load-path "/usr/lib64/chicken/5")

;; ============================================================= 
;; Custom Set Variables
;; ============================================================= 
(setq org-hide-leading-stars     t
      org-odd-levels-only        t
      inhibit-splash-screen      t          
      lpr-command                "xpp" ; Add support for gui printing in linux
      display-time-day-and-date  t
      display-time-24hr-format   t)

(setq-default indent-tabs-mode nil)     ;Tabs as spaces

;; ============================================================= 
;; Custom Set Functions
;; ============================================================= 
(fset 'yes-or-no-p 'y-or-n-p)        ; Make acknowledging stuff faster
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

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
(require 'cedet)
(require 'etags-update)

;; ============================================================= 
;; Winner Mode
;; ============================================================= 
(winner-mode 1)

;; ============================================================= 
;; Color Theme
;; ============================================================= 
(require 'color-theme)
(eval-after-load "color-theme"
 '(progn
    (load "~/jc-personal/site-lisp/naquadah-theme")))

;; =============================================================
;; Evil Mode
;; =============================================================
(setq evil-want-C-i-jump nil)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
