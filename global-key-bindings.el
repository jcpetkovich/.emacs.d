;; global-key-bindings.el - Global keybindings, look here for cool stuff.

;; =============================================================
;; Ace Jump Mode
;; =============================================================
(require-package 'ace-jump-mode)
(require-package 'ace-jump-buffer)
(require-package 'ace-link)

(require 'init-evil)

(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Emacs quick move minor mode" t)
(ace-link-setup-default)

(--each '(normal visual movement)
  (evil-declare-key it global-map
    (kbd "SPC") 'evil-ace-jump-word-mode
    (kbd "C-SPC") 'evil-ace-jump-line-mode))


(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; =============================================================
;; Helm!
;; =============================================================

;; setup-helm.el - configure helm and related packages

;;; Pull in global keybindings first
(require 'init-global-keybindings)
(require 'init-popwin)

(require-package 'helm)
(require-package 'helm-ls-git)
(require-package 'helm-swoop)
(require-package 'helm-R)
(require-package 'helm-descbinds)
(require-package 'helm-proc)
(require-package 'helm-cmd-t)
(require-package 'helm-ag)

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
(require 'helm-C-x-b)
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
      helm-exit-idle-delay 0.1
      helm-ls-git-status-command 'magit-status
      helm-candidate-number-limit 200
      helm-ff-search-library-in-sexp t
      ;; helm-ff-auto-update-initial-value t
      helm-ff-file-name-history-use-recentf t
      helm-home-url "https://www.google.ca"
      helm-follow-mode-persistent t)

(setq helm-ack-grep-executable "ack")
;;; Try reversing the defaults on which command should be the recursive one.
(setq helm-grep-default-command "ack -H --smart-case --nogroup --nocolour %e %p %f")
(setq helm-grep-default-recurse-command "ack -Hn --smart-case --nogroup --nocolour %e %p %f")

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
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-c <SPC>") 'helm-all-mark-rings)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-:") 'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-h d") 'helm-info-at-point)
(global-set-key (kbd "C-h f") 'describe-function)
(global-set-key (kbd "C-c g") 'helm-google-suggest)
(global-set-key (kbd "M-g M-s") 'helm-do-grep-wrapper)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "<f1>") 'helm-resume)
(global-set-key (kbd "C-h C-f") 'helm-apropos)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "M-o") 'helm-cmd-t)
(global-set-key (kbd "M-z") 'helm-cmd-t-grep)
(global-set-key (kbd "M-v") 'helm-semantic-or-imenu)
;; unbound (kbd "M-V")

;;; occur
(define-key global-map [remap occur] 'helm-occur)
(global-set-key (kbd "C-c m o") 'helm-multi-occur)
(define-key isearch-mode-map (kbd "C-c m o") 'helm-multi-occur-from-isearch)
(define-key isearch-mode-map (kbd "C-c o") 'helm-occur-from-isearch)

(define-key global-map [remap jump-to-register] 'helm-register)
(define-key global-map [remap list-buffers] 'helm-C-x-b)
(define-key global-map [remap find-tag] 'helm-etags-select)

;; =============================================================
;; Helm grep swap defaults
;; =============================================================
(defun helm-do-grep-wrapper (arg)
  (interactive "P")
  (let ((helm-grep-default-command "grep -a -d skip %e -n%cH -e %p %f")
        (helm-grep-default-recurse-command "grep -a -d recurse %e -n%cH -e %p %f")
        (current-prefix-arg (not arg)))
    (helm-do-grep)))

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
    (define-key map (kbd "C-w") 'kill-region-or-backward-word)
    (define-key map (kbd "M-w") 'helm-yank-text-at-point)))

(define-key helm-find-files-map (kbd "C-w") 'helm-find-files-up-one-level)

;; =============================================================
;; helm-C-x-b customizations
;; =============================================================
(setf helm-C-x-b-sources (--remove (eq it 'helm-source-cmd-t) helm-C-x-b-sources))
(setf helm-C-x-b-sources (-insert-at 1 'helm-source-ido-virtual-buffers helm-C-x-b-sources))
(setf helm-C-x-b-sources (-insert-at 2 'helm-source-cmd-t helm-C-x-b-sources))
(global-set-key (kbd "C-x b") 'helm-C-x-b)
(global-set-key (kbd "C-x C-b") 'helm-C-x-b)

;; =============================================================
;; Hack to swap order of sources in helm-ls-git
;; =============================================================
(defun helm-ls-git-ls ()
  (interactive)
  (helm :sources '(helm-source-ls-git
                   helm-source-ls-git-status)
        :default-directory default-directory
        :buffer "*helm lsgit*"))

;; =============================================================
;; Hack to fix rare error from helm--maybe-update-keymap
;; =============================================================
(defun helm--maybe-update-keymap ()
  "Handle differents keymaps in multiples sources.

It will override `helm-map' with the local map of current source.
If no map is found in current source do nothing (keep previous map)."
  (condition-case err
      (progn
        (with-helm-buffer
          (helm-aif (assoc-default 'keymap (helm-get-current-source))
              ;; Fix #466; we use here set-transient-map
              ;; to not overhide other minor-mode-map's.
              (if (fboundp 'set-transient-map)
                  (set-transient-map it)
                (set-temporary-overlay-map it)))))
    (error  (message "helm--maybe-update-keymap borked"))))

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

(provide 'init-helm)

;; =============================================================
;; Multiple Cursors
;; =============================================================

;;; setup-multiple-cursors.el - install/configure multiple cursors.

(require-package 'multiple-cursors)

;; =============================================================
;; Custom multiple cursors functions
;; =============================================================
(defun mc-expand-or-mark-next-symbol ()
  (interactive)
  (if (not (region-active-p))
      (er/mark-symbol)
    (call-interactively #'mc/mark-next-symbol-like-this)))

(defun mc-expand-or-mark-next-word ()
  (interactive)
  (if (not (region-active-p))
      (er/mark-word)
    (call-interactively #'mc/mark-next-word-like-this)))

;; =============================================================
;; Multiple cursors evil compat (use emacs mode during mc)
;; =============================================================
(defvar my-mc-evil-previous-state nil)
(defvar my-mark-was-active nil)

(defun my-mc-evil-switch-to-emacs-state ()
  (when (and (bound-and-true-p evil-mode)
             (not (memq evil-state '(insert emacs))))

    (setq my-mc-evil-previous-state evil-state)

    (when (region-active-p)
      (setq my-mark-was-active t))

    (let ((mark-before (mark))
          (point-before (point)))

      (evil-emacs-state 1)

      (when (or my-mark-was-active (region-active-p))
        (goto-char point-before)
        (set-mark mark-before)))))

(defun my-mc-evil-back-to-previous-state ()
  (when my-mc-evil-previous-state
    (unwind-protect
        (case my-mc-evil-previous-state
          ((normal visual) (evil-force-normal-state))
          (t (message "Don't know how to handle previous state: %S"
                      my-mc-evil-previous-state)))
      (setq my-mc-evil-previous-state nil)
      (setq my-mark-was-active nil))))

(add-hook 'multiple-cursors-mode-enabled-hook
          'my-mc-evil-switch-to-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook
          'my-mc-evil-back-to-previous-state)

(defun my-rrm-evil-switch-state ()
  (if rectangular-region-mode
      (my-mc-evil-switch-to-emacs-state)
    (setq my-mc-evil-previous-state nil)))

;;; When running edit-lines, point will return (position + 1) as a
;;; result of how evil deals with regions
(defadvice mc/edit-lines (before change-point-by-1 activate)
  (if (> (point) (mark))
      (goto-char (1- (point)))
    (push-mark (1- (mark)))))

(add-hook 'rectangular-region-mode-hook 'my-rrm-evil-switch-state)

(defvar mc--default-cmds-to-run-once nil)

;; =============================================================
;; Multiple cursors keybindings
;; =============================================================

;;; Strategy;
;; Use these keys (colemak layout):

;; | q | w | f | p |
;; |---+---+---+---|
;; | a | r | s | t |
;; |---+---+---+---|
;; | z | x | c | v |

;; Use right alt as A, build bindings offs-C-


(global-set-key (kbd "s-C-v s-C-v") 'mc/edit-ends-of-lines)

(global-set-key (kbd "s-C-#") 'mc/insert-numbers)
;;; Next key ->s-C-t (p)
;;  - `mc/mark-next-like-this`: Adds a cursor and region at the next part of the buffer forwards that matches the current region.
(global-set-key (kbd "s-C-t") 'mc/mark-next-like-this)
;;  - `mc/mark-next-word-like-this`: Like `mc/mark-next-like-this` but only for whole words.
(global-set-key (kbd "s-C-S-t") 'mc/mark-next-word-like-this)
;;  - `mc/mark-next-symbol-like-this`: Like `mc/mark-next-like-this` but only for whole symbols.
(global-set-key (kbd "s-C-p") 'mc/mark-next-symbol-like-this)

;;; Previous key ->s-C-s (f)
;;  - `mc/mark-previous-like-this`: Adds a cursor and region at the next part of the buffer backwards that matches the current region.
(global-set-key (kbd "s-C-s") 'mc/mark-previous-like-this)
;;  - `mc/mark-previous-word-like-this`: Like `mc/mark-previous-like-this` but only for whole words.
(global-set-key (kbd "s-C-S-s") 'mc/mark-previous-word-like-this)
;;  - `mc/mark-previous-symbol-like-this`: Like `mc/mark-previous-like-this` but only for whole symbols.
(global-set-key (kbd "s-C-f") 'mc/mark-previous-symbol-like-this)

;; ### Mark many occurrences

;;; Mark all key ->s-C-a (q)
;;  - `mc/mark-all-like-this`: Marks all parts of the buffer that matches the current region.
(global-set-key (kbd "s-C-a") 'mc/mark-all-like-this)
;;  - `mc/mark-all-words-like-this`: Like `mc/mark-all-like-this` but only for whole words.
(global-set-key (kbd "s-C-S-a") 'mc/mark-all-words-like-this)
;;  - `mc/mark-all-symbols-like-this`: Like `mc/mark-all-like-this` but only for whole symbols.
(global-set-key (kbd "s-C-q") 'mc/mark-all-symbols-like-this)

;;; Mark all limited by key ->s-C-r (w) (x)
;;  - `mc/mark-all-in-region`: Prompts for a string to match in the region, adding cursors to all of them.
(global-set-key (kbd "s-C-r") 'mc/mark-all-in-region)
;;  - `mc/mark-all-like-this-in-defun`: Marks all parts of the current defun that matches the current region.
(global-set-key (kbd "s-C-w") 'mc/mark-all-like-this-in-defun)
;;  - `mc/mark-all-words-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole words.
(global-set-key (kbd "s-C-S-w") 'mc/mark-all-words-like-this-in-defun)
;;  - `mc/mark-all-symbols-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole symbols.
(global-set-key (kbd "s-C-x") 'mc/mark-all-symbols-like-this-in-defun)

;;; Mark all god key ->s-C-c
;;  - `mc/mark-all-like-this-dwim`: Tries to be smart about marking everything you want. Can be pressed multiple times.
(global-set-key (kbd "s-C-c") 'mc/mark-all-like-this-dwim)

;; Quick keys
(global-set-key (kbd "M-m") 'mc-expand-or-mark-next-symbol)
(global-set-key (kbd "M-M") 'mc-expand-or-mark-next-word)
(global-set-key (kbd "M-'") 'mc/mark-all-dwim)

(provide 'init-multiple-cursors)

;; =============================================================
;; paredit and smart parens
;; =============================================================

(require 'init-evil)
(require-package 'paredit)
(require-package 'smartparens)

(require 'paredit)
(require 'smartparens-config)

(let ((turn-on-paredit-mode (lambda () (paredit-mode 1))))
  ;; some hooks: lisp-mode-hook and scheme-mode-hook are recommended
  ;; in the paredit source code
  (--each '(lisp-mode-hook scheme-mode-hook emacs-lisp-mode-hook slime-mode-hook cider-repl-mode-hook)
    (add-hook it turn-on-paredit-mode)))

(defadvice paredit-close-round (after paredit-close-and-indent activate)
  (cleanup-buffer))

;;; Laying paredit bindings on top of the smartparents one, not very
;;; pretty but this includes all the functions that I want to use.
(sp-use-smartparens-bindings)
(sp-use-paredit-bindings)
(setq-default sp-autoescape-string-quote nil)
(setq-default sp-autoskip-closing-pair 'always)
(setq-default sp-cancel-autoskip-on-backward-movement nil)

(evil-declare-key 'insert paredit-mode-map
  (kbd "C-k") 'paredit-kill)

(--each '(css-mode-hook
          markdown-mode-hook
          python-mode-hook
          sh-mode-hook
          ess-mode-hook
          haskell-mode-hook
          c-mode-hook
          LaTeX-mode-hook
          org-mode-hook
          sgml-mode-hook
          awk-mode-hook)
  (add-hook it 'turn-on-smartparens-strict-mode))

;;; Have to force some modes, as they are based on comint-mode
(--each '(inferior-ess-mode-hook)
  (add-hook it 'smartparens-mode))

;;; Fix smartparens-strict-mode-map for evil:
(evil-define-key 'insert smartparens-strict-mode-map
  (kbd "DEL") #'sp-backward-delete-char)

(defun kill-region-or-paredit-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (call-interactively 'paredit-backward-kill-word)))

(--each '(insert visual normal)
  (evil-declare-key it paredit-mode-map
    (kbd "C-w") 'kill-region-or-backward-word
    (kbd "M-;") 'comment-dwim-2))

(provide 'init-paredit)

;; =============================================================
;; req
;; =============================================================

;;; setup-req.el - req related configurations

;;; This stuff is pretty experimental.

;;; key bindings to select file or thing around point
(global-set-key [f9]
                (lambda ()(interactive)
                  (shell-command (concat
                            "req "
                            " -f emacs"
                            " -w \"$(dirname '" (buffer-file-name) "')\""
                            " '" (buffer-substring (region-beginning) (region-end) ) "'"))))

(provide 'init-req)

;; =============================================================
;; Visual Regexp
;; =============================================================
(require-package 'visual-regexp)
(require-package 'visual-regexp-steroids)

(global-set-key (kbd "M-%") 'vr/select-query-replace)
(global-set-key (kbd "s-C-5") 'vr/select-mc-mark)

(require 'visual-regexp)

(provide 'init-visual-regexp)

;; =============================================================
;; Old global keybindings
;; =============================================================

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
