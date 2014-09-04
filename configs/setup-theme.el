;;; setup-theme.el - setup the look and feel of emacs

(require 'cl)
(require 'uniquify)
(require 'saveplace)

;; =============================================================
;; Color Theme
;; =============================================================
(require-package 'smart-mode-line)
(require-package 'moe-theme)
(require 'moe-theme)
(require-package 'fancy-narrow)

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

(eval-after-load "init"
  '(dark))

(setq-default rm-blacklist '(" SliNav" " yas" " ElDoc" " Undo-Tree"
                             " AC" " Ref" " OrgTbl" " Doc" " Ind" " WSC"
                             " Projectile"))

(setq sml/replacer-regexp-list nil)
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
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords))

;; =============================================================
;; Line numbers
;; =============================================================
(require-package 'nlinum)

(global-nlinum-mode)
(defun nlinum--face-height (face)
  (condition-case err
      (aref (font-info (face-font face)) 2)
    (error (message "Unable to get font at this time.") 0)))

(add-hook 'rcirc-mode-hook (lambda () (nlinum-mode -1)))


;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq-default
 indent-tabs-mode                    nil
 save-place                          t
 inhibit-splash-screen               t
 lpr-command                         "xpp" ; default printing command
 display-time-day-and-date           nil
 display-time-24hr-format            nil
 backup-directory-alist              `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
 vc-make-backup-files                t
 save-interprogram-paste-before-kill t
 save-place-file                     (concat user-emacs-directory "places")
 mouse-wheel-scroll-amount           '(1)
 show-paren-style                    'expression)

;;; Make the frame title easy to search for among open windows
(setq-default frame-title-format
      (list
       '(:eval (if buffer-file-name (buffer-file-name) (buffer-name)))))

;;; No decorations please
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; Make acknowledging stuff faster
(fset 'yes-or-no-p 'y-or-n-p)

;;; Display time
(display-time)

;;; Save window configurations
(winner-mode 1)

(provide 'setup-theme)
