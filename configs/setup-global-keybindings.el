
;;; Load additional defuns
(require 'misc-defuns)
(require 'buffer-defuns)
(require 'editing-defuns)
(require 'file-defuns)
(require 'my-defuns)

;;; Load packages
(require-package 'expand-region)
(require-package 'smart-forward)
(require 'smart-forward)

;; =============================================================
;; All options for standard keybindings go in here
;; =============================================================

;; =============================================================
;; Set nice keybindings (combined with evil)
;; =============================================================
(windmove-default-keybindings)
;; (global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-S-b") 'ibuffer)
(global-set-key (kbd "M-;") 'comment-dwim)
(global-set-key (kbd "M-j") 'move-cursor-next-pane)
(global-set-key (kbd "M-k") 'move-cursor-previous-pane)
(global-set-key (kbd "M-l") 'shrink-window-horizontally)
(global-set-key (kbd "M-h") 'shrink-window)
(global-set-key (kbd "M-e") 'hippie-expand)
(global-set-key (kbd "M-SPC") 'hippie-expand-lines)
(global-set-key (kbd "C-<tab>") 'folding-toggle-show-hide)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-!") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-@") 'split-window-horizontally)
(global-set-key (kbd "<f11>") 'align-regexp)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c e") 'fc-eval-and-replace)
(global-set-key (kbd "C-c C-r") (lambda () (interactive) (message "Try visual mode and ',' instead")))
;; (global-set-key (kbd "C-x C-i") 'ido-imenu)
(global-set-key (kbd "C-ä") 'magit-status)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "<f4>") 'mu4e)
(global-set-key (kbd "<f2>") 'calc)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-M-=") 'er/contract-region)

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

;; Webjump let's you quickly search google, wikipedia, emacs wiki
(global-set-key (kbd "C-x g") 'webjump)
(global-set-key (kbd "C-x M-g") 'browse-url-at-point)

;; View occurrence in occur mode
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t M-w") 'transpose-words)
(global-set-key (kbd "M-t M-s") 'transpose-sexps)
(global-set-key (kbd "M-t M-l") 'transpose-lines)

;; Capitalization
(global-set-key (kbd "M-c M-c") 'capitalize-word)
(global-set-key (kbd "M-c M-l") 'downcase-word)
(global-set-key (kbd "M-c M-u") 'upcase-word)

;; Eshell
(global-set-key (kbd "M-c M-e") 'esh)

(global-set-key (kbd "<M-return>") 'new-line-dwim)
(global-set-key (kbd "M-RET") 'new-line-dwim)

;; =============================================================
;; Hooks for fixing keybindings in different modes
;; =============================================================

;; Hook for correcting behaviour in info mode
(add-hook 'Info-mode-hook
          (lambda ()
            (define-key Info-mode-map (kbd "M-s") 'other-window))) ; was Info-search

;; Hook for correcting behaviour in text mode
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map (kbd "M-s") 'other-window) ; was center-line
            (define-key text-mode-map (kbd "M-S") 'nil))) ; was center-paragraph

;; Hook for correcting behaviour in html mode
(add-hook 'html-mode-hook
          (lambda ()
            (define-key html-mode-map (kbd "M-s") 'other-window)))

;; =============================================================
;; Advice for builtins
;; =============================================================

(provide 'setup-global-keybindings)
