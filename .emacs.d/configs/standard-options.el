;; ============================================================= 
;; Load Path
;; ============================================================= 
(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme")

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
(ido-mode) ; ido-mode for better buffer switching and file finding, C-f to return to normal style

;; ============================================================= 
;; Require Statements - that dont fit elsewhere
;; ============================================================= 
(require 'cl)

;; ============================================================= 
;; Color Theme
;; ============================================================= 
(require 'color-theme)
(load-library "~/jc-personal/site-lisp/my-theme.el")
(eval-after-load "color-theme"
 '(progn
    (my-color-theme)))

;; ============================================================= 
;; YAsnippet
;; ============================================================= 
(yas/initialize)
(defun my-yas-load-dir (fn) 
  (if (file-readable-p fn)
      (yas/load-directory fn)))

(my-yas-load-dir "/usr/share/emacs/etc/yasnippet/snippets")
(my-yas-load-dir "/usr/share/emacs/site-lisp/yasnippet/snippets")

