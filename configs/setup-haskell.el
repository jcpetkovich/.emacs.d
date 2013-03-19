;; ;;; Code:

(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ghc-mod")

(autoload 'ghc-init "ghc" nil t)

(load "haskell-site-file")

(mapcar (lambda (my-hook)
          (add-hook 'haskell-mode-hook my-hook))
        '(turn-on-haskell-indent
          turn-on-font-lock
          turn-on-eldoc-mode
          turn-on-haskell-doc-mode
          imenu-add-menubar-index
          (lambda () (setq evil-auto-indent nil))))

(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; (add-hook 'haskell-mode-hook (lambda ()
;;                                (defvar ghc-completion-key  "\e\t")
;;                                (defvar ghc-document-key    "\e\C-d")
;;                                (defvar ghc-import-key      "\e\C-m")
;;                                (defvar ghc-previous-key    "\ep")
;;                                (defvar ghc-next-key        "\en")
;;                                (defvar ghc-help-key        "\e?")
;;                                (defvar ghc-insert-key      "\et")
;;                                (defvar ghc-sort-key        "\es")
;;                                (defvar ghc-type-key        "\C-c\C-t")
;;                                (defvar ghc-info-key        "\C-c\C-i")
;;                                (defvar ghc-check-key       "\C-x\C-s")
;;                                (defvar ghc-toggle-key      "\C-c\C-c")
;;                                (defvar ghc-module-key      "\C-c\C-m")
;;                                (defvar ghc-expand-key      "\C-c\C-e")
;;                                (defvar ghc-jump-key        "\C-c\C-j")
;;                                (defvar ghc-hoogle-key      (format "\C-c%c" (ghc-find-C-h)))
;;                                (defvar ghc-shallower-key   "\C-c<")
;;                                (defvar ghc-deeper-key      "\C-c>")))


;; ;; Haskell
;; (defun ac-haskell-hoogle (prefix)
;;   (let (expansion all-expansions end-of-period)
;;     (with-temp-buffer
;;       ;; Remove period from end of line.
;;       (when (string-match "\\(.*\\)\\.$" prefix)
;;         (setq prefix (match-string 1 prefix))
;;         (setq end-of-period t))
;;       ;; Search candidate use `hoogle'.
;;       (call-process  "hoogle" nil t nil "" prefix)
;;       ;; Get match candidate.
;;       (goto-char (point-min))
;;       (while (re-search-forward
;;               "^\\(\\(module\\|keyword\\|Prelude\\|Data\\|Language\\.Haskell[^ ]*\\)\\( type\\| class\\)?\\)[ \\.]\\([^ \n]+\\)"
;;               nil t)
;;         (setq expansion (match-string 4))
;;         (setq all-expansions (cons expansion all-expansions)))
;;       ;; Search class.
;;       (goto-char (point-min))
;;       (while (re-search-forward
;;               "^Prelude class .*=> \\([^ \n]+\\)"
;;               nil t)
;;         (setq expansion (match-string 1))
;;         (setq all-expansions (cons expansion all-expansions)))
;;       ;; Search calss level.
;;       (goto-char (point-min))
;;       ;; Add period when option `end-of-period'
;;       ;; is `non-nil'.
;;       (when end-of-period
;;         (setq prefix (format "%s." prefix)))
;;       (while (re-search-forward
;;               (format "^%s[^ \n]+" prefix)
;;               nil t)
;;         (setq expansion (match-string 0))
;;         (setq all-expansions (cons expansion all-expansions))))
;;     all-expansions))

;; ;; http://www.haskell.org/ghc/docs/latest/html/users_guide/pragmas.html
;; (defconst ac-haskell-ghc-pragmas
;;   (sort
;;    (list "LANGUAGE" "OPTIONS_GHC" "INCLUDE" "WARNING" "DEPRECATED" "INLINE" "NOINLINE"
;;          "LINE" "RULES" "SPECIALIZE" "UNPACK" "SOURCE")
;;    #'(lambda (a b) (> (length a) (length b))))
;;   "GHC pragmas.")

;; (defconst ac-haskell-defined-punctunation
;;   (sort
;;    (list "==" "/=" "<=" ">=" ">>=" ">>" "**" "^^")
;;    #'(lambda (a b) (> (length a) (length b))))
;;   "Defined punctunation in Haskell.")

;; (defconst ac-haskell-misc
;;   (sort
;;    (list "-fglasgow-exts")
;;    #'(lambda (a b) (> (length a) (length b))))
;;   "GHC pragmas.")

;; (defvar ac-source-haskell
;;   '((candidates . (lambda ()
;;                     (all-completions ac-target
;;                                      (append nil
;;                                              ac-haskell-defined-punctunation
;;                                              ac-haskell-ghc-pragmas
;;                                              (ac-haskell-hoogle ac-target)
;;                                              ac-haskell-misc)))))
;;   "Sources for Haskell keywords.")

;; (add-hook 'haskell-mode-hook '(lambda ()
;;                                 (add-to-list 'ac-sources 'ac-source-haskell)))

(provide 'setup-haskell)
