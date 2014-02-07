;; setup-helm.el - configure helm and related packages

;;; Pull in global keybindings first
(require 'setup-global-keybindings)

(require-package 'helm)
(require-package 'helm-ls-git)
(require-package 'helm-swoop)
(require 'helm-config)
(require 'helm-ls-git)
(helm-mode 1)

;; =============================================================
;; helm settings
;; =============================================================
(setq helm-adaptative-mode t
      helm-quick-update t
      helm-idle-delay 0.01
      helm-input-idle-delay 0.01
      helm-m-occur-idle-delay 0.01
      helm-ls-git-status-command 'magit-status
      helm-candidate-number-limit 200
      helm-ff-search-library-in-sexp t
      helm-ff-auto-update-initial-value t)

;; (setq helm-ff-skip-boring-files t)

;; (-each (list "\\.pyc$")
;;   (lambda (regexp)
;;     (add-to-list 'helm-boring-file-regexp-list regexp)))

(defvar all-helm-maps (list helm-map
                            helm-etags-map
                            helm-moccur-map
                            helm-grep-map
                            helm-pdfgrep-map
                            helm-generic-files-map))

;;; helm bindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-c <SPC>") 'helm-all-mark-rings)
;; (global-set-key (kbd "C-x r b") 'helm-bookmark-ext)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-:") 'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-h d") 'helm-info-at-point)
(global-set-key (kbd "C-c g") 'helm-google-suggest)
(global-set-key (kbd "M-g s") 'helm-do-grep)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "<f1>") 'helm-resume)
(global-set-key (kbd "C-h C-f") 'helm-apropos)
;; (global-set-key (kbd "<f5> s") 'helm-find)
(define-key global-map [remap jump-to-register] 'helm-register)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
;; (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap find-tag] 'helm-etags-select)
;; (define-key shell-mode-map (kbd "M-p") 'helm-comint-input-ring)

;;; helm-ls-git bindings
(global-set-key (kbd "C-x C-o") 'helm-ls-git-ls)

;;; Muscle memory
(-each all-helm-maps
  (lambda (map)
    (define-key map [remap helm-yank-text-at-point] 'backward-kill-word)))

(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-M-i") 'helm-select-action)

;;; Additional helm actions
(helm-add-action-to-source
 "Magit status"
 #'(lambda (_candidate)
     (with-helm-buffer (magit-status helm-default-directory)))
 helm-source-ls-git 1)
