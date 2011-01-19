(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

(defun open-ruby-section ()
  "Insert <p></p> at cursor point."
  (interactive)
  (insert "<%  %>")
  (backward-char 3))

(add-hook 'nxhtml-mode-hook
          (lambda ()
            (define-key nxhtml-mode-map  (kbd "\C-c\C-r") 'open-ruby-section)))

(require 'rcodetools)
(require 'icicles-rcodetools)
(describe-function 'xmp)
(describe-function 'comment-dwim)
;; (describe-function 'rct-complete-symbol)

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "\C-c\C-c\C-c") 'xmp)))

;; (icicle-define-command rct-complete-symbol--icicles
;;                          "Perform ruby method and class completion on the text around point with icicles.
;; C-M-RET shows RI documentation on each candidate.
;; See also `rct-interactive'."

;;                        (lambda (result)
;;                          (save-excursion
;;                            (search-backward pattern)
;;                            (setq beg (point)))
;;                          (delete-region beg end)
;;                          (insert (car (split-string result)))) ;/function
;;                        "rct-complete: "       ;prompt
;;                        rct-method-completion-table
;;                        nil nil pattern nil nil nil
;;                        ((end (point)) beg
;;                         (icicle-list-join-string "\t")
;;                         (icicle-list-nth-parts-join-string "\t")
;;                         (icicle-list-use-nth-parts '(1))
;;                         (icicle-point-position-in-candidate 'input-end)
;;                         pattern klass alist
;;                         (icicle-candidate-help-fn
;;                          (lambda (result)
;;                            (ri (cdr (assoc result alist)))))) ;bindings
;;                        (save-excursion (rct-exec-and-eval rct-complete-command-name "--completion-emacs-icicles")))

(setq rsense-home "/home/jcp/src/ruby/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

(add-hook 'ruby-mode-hook 'auto-complete-mode)
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "M-<tab>") 'ac-complete-rsense)))


;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (define-key ruby-mode-map (kbd "M-<tab>") 'rsense-complete)))uu


(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key [f1] 'yari)))

(setq rsense-rurema-home "~/.ruby-reference-manual")
