;; ============================================================= 
;; Load Path
;; ============================================================= 
(add-to-list 'load-path "~/jc-personal/site-lisp/")
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



;; (setq swank-clojure-extra-classpaths (list "/home/jcp/src/clojure"))

;; (setf swank-clojure-classpath '("/home/jcp/src/clojure" "/home/jcp/src/clojure/src" "/home/jcp/src/clojure/classes" "/usr/share/clojure/lib/clojure.jar" "/home/jcp/.swank-clojure/clojure-contrib-1.1.0-master-20091212.205045-1.jar" "/home/jcp/.swank-clojure/swank-clojure-1.1.0.jar"))

;; (setf swank-clojure-classpath '("/home/jcp" "/home/jcp/.swank-clojure/clojure-1.1.0-master-20091202.150145-1.jar" "/home/jcp/.swank-clojure/clojure-contrib-1.1.0-master-20091212.205045-1.jar" "/home/jcp/src/clojure/classes" "/home/jcp/src/clojure/src" "/home/jcp/src/clojure" "/home/jcp/.swank-clojure/swank-clojure-1.1.0.jar"))





;; (add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

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
 '(LaTeX-beamer-item-overlay-flag nil)
 '(TeX-master nil)
 '(ac-ignore-case nil)
 '(browse-kill-ring-quit-action (quote save-and-restore))
 '(c-basic-offset 4)
 '(c-insert-tab-function (quote tab-to-tab-stop))
 '(c-offsets-alist (quote ((substatement . 0) (substatement-open . 0) (substatement-label . 0))))
 '(cluck-fontify-style nil)
 '(cperl-continued-statement-offset 0)
 '(ecb-layout-name "left7")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote ("/home/jcp/jc-personal/org/" "/home/jcp/src/" "/home/jcp/Documents/" "/")))
 '(ecb-windows-width 0.2)
 '(erc-header-line-face-method t)
 '(eshell-cmpl-ignore-case t)
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(haskell-mode-hook (quote (turn-on-haskell-indent turn-on-font-lock turn-on-eldoc-mode turn-on-haskell-doc-mode imenu-add-menubar-index)))
 '(haskell-program-name "ghci -XTemplateHaskell")
 '(ido-create-new-buffer (quote always))
 '(ido-mode (quote both) nil (ido))
 '(jde-global-classpath (quote (".")))
 '(make-backup-files nil)
 '(org-agenda-files (quote ("/home/jcp/jc-personal/org")))
 '(org-hide-leading-stars t)
 '(org-src-fontify-natively t)
 '(quack-fontify-style nil)
 '(quack-programs (quote ("racket" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-remap-find-file-bindings-p nil)
 '(safe-local-variable-values (quote ((folded-file . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(slime-complete-symbol-function (quote slime-simple-complete-symbol))
 '(speedbar-use-images t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(user-mail-address "me@jcpetkovich.com")
 '(vimpulse-want-C-i-like-Vim nil)
 '(viper-ex-style-motion nil)
 '(viper-fast-keyseq-timeout 0)
 '(w3m-default-display-inline-images t)
 '(x-select-enable-clipboard t)
 '(yas/indent-line (quote auto)))
 

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "Black")))))


(put 'narrow-to-region 'disabled nil)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))

;; (add-to-list 'package-archives
;;              '("technomancy" . "http://repo.technomancy.us/emacs/") t)
