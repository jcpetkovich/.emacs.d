;; setup-helm.el - configure helm and related packages

;;; Pull in global keybindings first
(require 'setup-global-keybindings)
(require 'setup-popwin)

(require-package 'helm)
(require-package 'helm-ls-git)
(require-package 'helm-swoop)
(require-package 'helm-R)
(require-package 'helm-descbinds)
(require-package 'helm-proc)

;;; For keychords to lower usage of pinky
(require-package 'key-chord)
(require 'key-chord)

(setq key-chord-two-keys-delay .015
      key-chord-one-key-delay .020)

(key-chord-mode 1)

(key-chord-define-global "8l" 'helm-find-files)
(key-chord-define-global "4p" 'helm-buffers-list)

(require 'helm-config)
(require 'helm-ls-git)
(helm-mode 1)
(helm-descbinds-mode 1)

;; =============================================================
;; Enable recentf for helm-buffers-list
;; =============================================================
(recentf-mode 1)
(setq recentf-max-saved-items 1000)

;; =============================================================
;; ido settings for helm
;; =============================================================

(setq ido-use-virtual-buffers t)

;; =============================================================
;; make helm a little smaller
;; =============================================================

(push '("^\*[Hh]elm.+\*$" :regexp t :height 25 :stick t)  popwin:special-display-config)

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
      ;; helm-ff-auto-update-initial-value t
      helm-ff-file-name-history-use-recentf t
      helm-home-url "https://www.google.ca"
      helm-follow-mode-persistent t)

(setq helm-ack-grep-executable "ack")
(setq helm-grep-default-command "ack -Hn --smart-case --nogroup --nocolour %e %p %f")
(setq helm-grep-default-recurse-command "ack -H --smart-case --nogroup --nocolour %e %p %f")

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
;; =============================================================
;; helm bindings
;; =============================================================

;;; I don't like C-z, it hurts my hands
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-M-i") 'helm-select-action)

;;; Use helm alternatives
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-c <SPC>") 'helm-all-mark-rings)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-:") 'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-h d") 'helm-info-at-point)
(global-set-key (kbd "C-h f") 'describe-function)
(global-set-key (kbd "C-c g") 'helm-google-suggest)
(global-set-key (kbd "M-g s") 'helm-do-grep)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "<f1>") 'helm-resume)
(global-set-key (kbd "C-h C-f") 'helm-apropos)
(global-set-key (kbd "C-h a") 'helm-apropos)

;;; occur
(define-key global-map [remap occur] 'helm-occur)
(global-set-key (kbd "C-c m o") 'helm-multi-occur)
(define-key isearch-mode-map (kbd "C-c m o") 'helm-multi-occur-from-isearch)
(define-key isearch-mode-map (kbd "C-c o") 'helm-occur-from-isearch)

;; (global-set-key (kbd "<f5> s") 'helm-find)
(define-key global-map [remap jump-to-register] 'helm-register)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap find-tag] 'helm-etags-select)
;; (define-key shell-mode-map (kbd "M-p") 'helm-comint-input-ring)

;; =============================================================
;; helm-ls-git bindings
;; =============================================================
(global-set-key (kbd "C-x C-o") 'helm-ls-git-ls)

;; =============================================================
;; helm-swoop bindings
;; =============================================================

(defun helm-swoop-custom (arg)
  "I don't want to have a query by default."
  (interactive "P")
  (if arg
      (helm-swoop :$multiline nil)
    (helm-swoop :$query "" :$multiline nil)))

(global-set-key (kbd "M-i") 'helm-swoop-custom)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)


;;; Muscle memory
(-each all-helm-maps
  (lambda (map)
    (define-key map (kbd "C-w") 'backward-kill-word)
    (define-key map (kbd "M-w") 'helm-yank-text-at-point)))

(define-key helm-find-files-map (kbd "C-w") 'helm-find-files-down-one-level)

;; =============================================================
;; Hack to swap order of sources in helm-ls-git
;; =============================================================

;;;###autoload
(defun helm-ls-git-ls ()
  (interactive)
  (helm :sources '(helm-source-ls-git
                   helm-source-ls-git-status)
        :default-directory default-directory
        :buffer "*helm lsgit*"))

;; (defvar helm-source-example
;;   '((name . "this example's cool extension")
;;     (init . (lambda ()
;;               (let ((candidates '("one" "two" "three")))
;;                 (helm-init-candidates-in-buffer 'global candidates))))
;;     (candidates-in-buffer)
;;     (match . identity)
;;     (action . (("Print that thing"
;;                 . (lambda (candidate) (message "This was the candidate %s" candidate)))))))


;; (defun helm-example ()
;;   (interactive)
;;   (helm-other-buffer 'helm-source-example "*Helm Example*"))

(provide 'setup-helm)
