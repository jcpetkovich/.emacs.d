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

(find-file my-notes-file)

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
 '(cperl-auto-newline nil)
 '(cperl-auto-newline-after-colon nil)
 '(cperl-autoindent-on-semi t)
 '(cperl-continued-statement-offset 0)
 '(cperl-highlight-variables-indiscriminately t)
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ecb-layout-name "left7")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote ("/home/jcp/src/" "/home/jcp/Documents/" "/")))
 '(ecb-windows-width 0.2)
 '(erc-header-line-face-method t)
 '(eshell-cmpl-ignore-case t)
 '(ess-default-style (quote OWN))
 '(ess-own-style-list (quote ((ess-indent-level . 4) (ess-continued-statement-offset . 4) (ess-brace-offset . 0) (ess-expression-offset . 4) (ess-else-offset . 0) (ess-brace-imaginary-offset . 0) (ess-continued-brace-offset . 0) (ess-arg-function-offset . 2) (ess-close-brace-offset . 0))))
 '(evil-cross-lines t)
 '(evil-default-cursor t)
 '(evil-esc-delay 0)
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(haskell-program-name "ghci -XTemplateHaskell")
 '(hippie-expand-dabbrev-skip-space t)
 '(ido-create-new-buffer (quote always))
 '(ido-mode (quote both) nil (ido))
 '(jde-global-classpath (quote (".")))
 '(make-backup-files nil)
 '(mouse-wheel-mode nil)
 '(org-completion-use-ido t)
 '(org-default-notes-file "~/org/captured.org")
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.pdf\\'" . "evince %s"))))
 '(org-hide-leading-stars t)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-src-fontify-natively t)
 '(pde-abbv-use-snippet nil)
 '(py-electric-colon-active-p t)
 '(quack-fontify-style nil)
 '(quack-programs (quote ("racket" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-remap-find-file-bindings-p nil)
 '(ruby-block-highlight-face (quote fringe))
 '(ruby-block-highlight-toggle (quote overlay))
 '(safe-local-variable-values (quote ((folded-file . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(slime-complete-symbol-function (quote slime-simple-complete-symbol))
 '(speedbar-use-images t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(tags-table-list nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(user-mail-address "jcpetkovich@gmail.com")
 '(vimpulse-want-C-i-like-Vim nil)
 '(viper-ex-style-motion nil)
 '(viper-fast-keyseq-timeout 0)
 '(w3m-default-display-inline-images t)
 '(x-select-enable-clipboard t)
 '(x-select-enable-primary t)
 '(yas-indent-line (quote auto)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "Black"))) t))

(put 'narrow-to-region 'disabled nil)
