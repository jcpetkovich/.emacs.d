;; =============================================================
;; Load Path
;; =============================================================
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-powerline")
(add-to-list 'load-path "~/.emacs.d/site-lisp/solarized-emacs")

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

;; =============================================================
;; Winner Mode
;; =============================================================
(winner-mode 1)


;; =============================================================
;; Color Theme
;; =============================================================

(require 'powerline)

;; Setup modeline items
(defun gcs-propertized-evil-mode-tag ()
  (propertize evil-mode-line-tag 'font-lock-face
              ;; Don't propertize if we're not in the selected buffer
              (cond ((not (eq (current-buffer) (car (buffer-list)))) '())
                    ((evil-emacs-state-p) '(:background "red"))
                    (t '()))))

(setq-default
 mode-line-format
 (list "%e"
       '(:eval (concat
                (gcs-propertized-evil-mode-tag)
                (powerline-rmw            'left   nil  )
                (powerline-buffer-id      'left   nil  powerline-color1  )
                (powerline-major-mode     'left        powerline-color1  )
                (powerline-minor-modes    'left        powerline-color1  )

                (when (boundp 'erc-modified-channels-object)
                  (powerline-make-left erc-modified-channels-object
                                       powerline-color1))
                (powerline-narrow         'left        powerline-color1  powerline-color2  )
                (powerline-vc             'center                        powerline-color2  )
                (powerline-make-fill                                     powerline-color2  )
                (powerline-row            'right       powerline-color1  powerline-color2  )
                (powerline-make-text      ":"          powerline-color1  )
                (powerline-column         'right       powerline-color1  )
                (powerline-percent        'right  nil  powerline-color1  )
                (powerline-make-text      "  "    nil  )))))

(load "solarized-dark-theme")

(custom-theme-set-faces
 'solarized-dark
 `(comint-highlight-prompt ((t (:foreground "#268bd2"))))

 `(font-lock-keyword-face ((((class color) (min-colors 89)) (:foreground "#859900" :weight bold)))))

(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")

(set-face-attribute 'mode-line nil
                    :foreground "#fdf6e3"
                    :background "#859900"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :box nil)

(defun dark ()
  (interactive)
  (load-theme 'solarized-dark)
  (setq powerline-color1 "grey22")
  (setq powerline-color2 "grey40")

  (set-face-attribute 'mode-line nil
                      :foreground "#fdf6e3"
                      :background "#859900"
                      :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :box nil))

(defun light ()
  (interactive)
  (load-theme 'solarized-light)
  (custom-theme-set-faces
   'solarized-light
   `(comint-highlight-prompt ((t (:foreground "#268bd2"))))
   `(font-lock-keyword-face ((((class color) (min-colors 89)) (:foreground "#859900" :weight bold)))))

  (setq powerline-color1 "#657b83")
  (setq powerline-color2 "#839496")

  (set-face-attribute 'mode-line nil
                      :foreground "#fdf6e3"
                      :background "#859900"
                      :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :box nil))

;; =============================================================
;; Evil Mode
;; =============================================================

(eval-after-load "init"
  '(progn
     (setq evil-want-C-i-jump nil)
     (setq evil-want-C-u-scroll t)
     (require 'evil)
     (evil-mode 1)))

(provide 'setup-theme)
