
;;; Encryption
(require 'epa-file)
(epa-file-enable)

;; =============================================================
;; Load Path
;; =============================================================
(defconst user-emacs-directory "~/.emacs.d/")
(defconst ini-configs-directory (expand-file-name (concat user-emacs-directory "configs")))
(defconst ini-defuns-directory (expand-file-name (concat user-emacs-directory "defuns")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path ini-configs-directory)
(add-to-list 'load-path ini-defuns-directory)

(defvar ini-loaded '())

(defun load-with-message (filespec)
  (message (concat "Loading " filespec))
  (load filespec)
  (push filespec ini-loaded))

(mapc #'load-with-message 
      (directory-files ini-configs-directory nil "^setup.*\\.el$"))

(when (file-exists-p my-notes-file)
  (find-file my-notes-file))

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
 '(haskell-program-name "ghci -XTemplateHaskell")
 '(hippie-expand-dabbrev-skip-space t)
 '(ido-create-new-buffer (quote always))
 '(ido-mode (quote both) nil (ido))
 '(jde-global-classpath (quote (".")))
 '(make-backup-files nil)
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
