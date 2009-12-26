;; ============================================================= 
;; Load Path
;; ============================================================= 
(add-to-list 'load-path "/home/jcp/jc-personal/site-lisp/")
(defconst ini-directory "~/.emacs.d/configs")

;; ============================================================= 
;; Load All ini-directory files
;; Author: Jim Weirich
;; ============================================================= 

(defvar ini-loaded ()
  "List of files loaded during initialization.")

(defvar ini-not-loaded ()
  "List of files that failed to load during initialization.")

(defun ini-try-load (inifn ext)
  "Attempt to load an ini-type elisp file."
  (let ((fn (concat ini-directory "/" inifn ext)))
    (if (file-readable-p fn)
        (progn
          (message (concat "Loading " inifn))
          (load-file fn)
          (setq ini-loaded (cons inifn ini-loaded)) ))))

(defun ini-load (inifn)
  "Load a ini-type elisp file"
  (cond ((ini-try-load inifn ".elc"))
        ((ini-try-load inifn ".el"))
        (t (setq ini-not-loaded (cons inifn ini-not-loaded))
           (message (concat inifn " not found")))))

(let ((files (directory-files ini-directory nil "^.*\\.el$")))
  (while (not (null files))
    (ini-load (substring (car files) 0 -3))
    (setq files (cdr files)) ))

;; ADD THESE TO HOOKS LATER
;; ;; ============================================================= 
;; ;; C and C like language variables
;; ;; ============================================================= 
;; (setq c-basic-offset 4
;;       c-offsets-alist (quote ((substatement . 0) (substatement-open . 0) (substatement-label . 0))))

;; ;; ============================================================= 
;; ;; ECB variables
;; ;; ============================================================= 
;; (setq ecb-layout-name "left7"
;;       ecb-options-version "2.40"
;;       ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)
;;       ecb-show-sources-in-directories-buffer (quote always)
;;       ecb-source-path (quote ("/home/jcp/jc-personal/org/" "/home/jcp/src/" "/home/jcp/Documents/" "/"))
;;       ecb-windows-width 0.2)
;; (setq speedbar-use-images t)

;; ;; ============================================================= 
;; ;; ERC variables
;; ;; ============================================================= 
;; (setq erc-header-line-face-method t)


;; ;; ============================================================= 
;; ;; IDO variables
;; ;; ============================================================= 
;; (setq ido-create-new-buffer (quote always))

;; ;; ============================================================= 
;; ;; ORG variables
;; ;; ============================================================= 
;; (setq org-agenda-files (quote ("/home/jcp/jc-personal/org"))
;;       org-hide-leading-stars t)

;; ;; ============================================================= 
;; ;; EMACS variables
;; ;; ============================================================= 
;; (setq safe-local-variable-values (quote ((folded-file . t))))
;; (setq show-paren-mode t)
;; (setq tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
;;       tab-width 4)
;; (setq x-select-enable-clipboard t)

;; ;; ============================================================= 
;; ;; SLIME variables
;; ;; ============================================================= 
;; (setq slime-complete-symbol-function (quote slime-simple-complete-symbol))

;; ;; ============================================================= 
;; ;; MAIL variables
;; ;; ============================================================= 
;; (setq user-mail-address "jcpetkovich@gmail.com")

;; ;; ============================================================= 
;; ;; VIPER variables
;; ;; ============================================================= 
;; (setq viper-ex-style-motion nil
;;       viper-fast-keyseq-timeout 0)
;; ============================================================= 
;; Variables Set by emacs
;; ============================================================= 

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-insert-tab-function (quote tab-to-tab-stop))
 '(c-offsets-alist (quote ((substatement . 0) (substatement-open . 0) (substatement-label . 0))))
 '(ecb-layout-name "left7")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote ("/home/jcp/jc-personal/org/" "/home/jcp/src/" "/home/jcp/Documents/" "/")))
 '(ecb-windows-width 0.2)
 '(erc-header-line-face-method t)
 '(haskell-mode-hook (quote (turn-on-haskell-indent turn-on-font-lock turn-on-eldoc-mode turn-on-haskell-doc-mode imenu-add-menubar-index)))
 '(ido-create-new-buffer (quote always))
 '(org-agenda-files (quote ("/home/jcp/jc-personal/org")))
 '(org-hide-leading-stars t t)
 '(safe-local-variable-values (quote ((folded-file . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(slime-complete-symbol-function (quote slime-simple-complete-symbol))
 '(speedbar-use-images t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
 '(tab-width 4)
 '(user-mail-address "me@jcpetkovich.com")
 '(viper-ex-style-motion nil)
 '(viper-fast-keyseq-timeout 0)
 '(x-select-enable-clipboard t)
 '(yas/indent-line (quote auto)))
 

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
