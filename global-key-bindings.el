
;;; Load additional defuns
(require 'misc-defuns)
(require 'buffer-defuns)
(require 'editing-defuns)
(require 'file-defuns)
(require 'my-defuns)

;;; Load packages
(require-package 'expand-region)
(require-package 'smart-forward)
(require-package 'comment-dwim-2)
(require 'smart-forward)

;; =============================================================
;; Set nice keybindings (combined with evil)
;; =============================================================
(global-set-key (kbd "M-;") 'comment-dwim-2)
(global-set-key (kbd "M-j") 'move-cursor-next-pane)
(global-set-key (kbd "M-k") 'move-cursor-previous-pane)
(global-set-key (kbd "M-e") 'hippie-expand)
(global-set-key (kbd "M-SPC") 'hippie-expand-lines)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-!") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-@") 'split-window-horizontally)
(global-set-key (kbd "<f2>") 'calc)
(global-set-key (kbd "<f4>") 'mu4e)
(global-set-key (kbd "<f11>") 'align-regexp)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c e") 'fc-eval-and-replace)
(global-set-key (kbd "C-c C-r") (lambda () (interactive) (message "Try visual mode and ',' instead")))
(global-set-key (kbd "C-ä") 'magit-status)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "C-\"") 'er/contract-region)

;;; Unbound (or mostly useless) but convenientish keys
;; (kbd "M-u")
;; (kbd "M-n") ; usually bound during certain modes
;; (kbd "M-p") ; usually bound during certain modes
;; (kbd "M-l")
;; (kbd "M-h")
;; (kbd "M-~")
;; (kbd "M-`")
;; (kbd "M-\"")
;; (kbd "C-=")
;; (kbd "C-M-=")
;; (kbd "C-;")
;; (kbd "M-O")

;; Note for the big rebind, M-e, and M-a should be off-limits, and are
;; pretty useful.

;; =============================================================
;;; Neat stuff from Magnars
;; =============================================================
(global-unset-key (kbd "M-c"))
(global-set-key (kbd "C-c C--") 'replace-next-underscore-with-camel)
(global-set-key (kbd "M-c M--") 'snakeify-current-word)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Copy file path to kill ring
(global-set-key (kbd "C-x M-w") 'copy-current-file-path)

;; Window switching
(global-set-key (kbd "C-x C--") 'rotate-windows)

;; Revert without any fuss
(global-set-key (kbd "M-<escape>") (λ (revert-buffer t t)))

;;; Navigation coolness with smart movement
(global-set-key (kbd "M-<up>") 'smart-up)
(global-set-key (kbd "M-<down>") 'smart-down)
(global-set-key (kbd "M-<left>") 'smart-backward)
(global-set-key (kbd "M-<right>") 'smart-forward)

;; View occurrence in occur mode
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t M-w") 'transpose-words)
(global-set-key (kbd "M-t M-s") 'transpose-sexps)
(global-set-key (kbd "M-t M-l") 'transpose-lines)
(global-set-key (kbd "M-t M-p") 'transpose-params)

;; Capitalization
(global-set-key (kbd "M-c M-c") 'capitalize-word)
(global-set-key (kbd "M-c M-l") 'downcase-word)
(global-set-key (kbd "M-c M-u") 'upcase-word)

;; Eshell
(global-set-key (kbd "M-c M-e") 'esh)

(global-set-key (kbd "<M-return>") 'new-line-dwim)
(global-set-key (kbd "M-RET") 'new-line-dwim)

(provide 'global-key-bindings)
