;; global-key-bindings.el - Global keybindings, look here for cool stuff.

;; =============================================================
;; Ace Jump Mode
;; =============================================================

(req-package ace-jump-mode
  :require (evil dash)
  :bind ("C-x SPC" . ace-jump-mode-pop-mark)
  :config
  (progn
    (--each '(normal visual movement)
      (evil-declare-key it global-map
        (kbd "SPC") 'evil-ace-jump-word-mode
        (kbd "C-SPC") 'evil-ace-jump-line-mode))
    (ace-jump-mode-enable-mark-sync)))

(req-package ace-link
  :require ace-jump-mode
  :init (ace-link-setup-default))

;; =============================================================
;; Helm!
;; =============================================================
(req-package helm
  :require (helm-ls-git
            helm-swoop
            helm-R
            helm-descbinds
            helm-proc
            helm-cmd-t
            helm-ag
            helm-company
            company)

  :bind
  (("M-x"       . helm-M-x)
   ("M-y"       . helm-show-kill-ring)
   ("C-x C-f"   . helm-find-files)
   ("C-c f"     . helm-recentf)
   ("C-c <SPC>" . helm-all-mark-rings)
   ("C-h r"     . helm-info-emacs)
   ("C-:"       . helm-company)
   ("C-h d"     . helm-info-at-point)
   ("C-c g"     . helm-google-suggest)
   ("C-x C-d"   . helm-browse-project)
   ("C-h C-f"   . helm-apropos)
   ("C-h a"     . helm-apropos)
   ("M-o"       . helm-cmd-t)
   ("M-z"       . helm-cmd-t-grep)
   ("M-v"       . helm-semantic-or-imenu)
   ("M-i"       . helm-swoop-custom)
   ("M-I"       . helm-swoop-back-to-last-point)
   ("C-c M-i"   . helm-multi-swoop)
   ("C-x M-i"   . helm-multi-swoop-all)
   ("C-x b"     . helm-C-x-b)
   ("C-x C-b"   . helm-C-x-b))

  :init
  (progn

    (require 'helm-config)
    (require 'helm-ls-git)
    (require 'helm-C-x-b)

    (defun helm-swoop-custom (arg)
      "I don't want to have a query by default."
      (interactive "P")
      (if arg
          (helm-swoop :$multiline nil)
        (helm-swoop :$query "" :$multiline nil)))

    (defun helm-do-grep-wrapper (arg)
      (interactive "P")
      (let ((current-prefix-arg (not arg)))
        (helm-do-grep)))

    )
  :config
  (progn

    (defvar all-helm-maps (list helm-map
                                helm-etags-map
                                helm-moccur-map
                                helm-grep-map
                                helm-pdfgrep-map
                                helm-generic-files-map))


    (bind-keys :map helm-map
               ("C-i" . helm-execute-persistent-action)
               ("C-M-i" . helm-select-action))

    (bind-keys :map global-map
               ("M-g M-s"   . helm-do-grep-wrapper)
               ("<f1>"      . helm-resume)
               ("C-c m o" . helm-multi-occur)
               ("C-x C-o" . helm-ls-git-ls))

    (define-key global-map [remap occur] 'helm-occur)
    (define-key global-map [remap jump-to-register] 'helm-register)
    (define-key global-map [remap list-buffers] 'helm-C-x-b)
    (define-key global-map [remap find-tag] 'helm-etags-select)

    (bind-keys :map isearch-mode-map
               ("C-c m o" . helm-multi-occur-from-isearch)
               ("C-c o" . helm-occur-from-isearch))

    (-each all-helm-maps
      (lambda (map)
        (define-key map (kbd "C-w") 'kill-region-or-backward-word)
        (define-key map (kbd "M-w") 'helm-yank-text-at-point)))

    (define-key helm-find-files-map (kbd "C-w") 'helm-find-files-up-one-level)

    ;; =============================================================
    ;; Helm Settings
    ;; =============================================================

    (helm-mode 1)
    (helm-descbinds-mode 1)

    (recentf-mode 1)
    (setq recentf-max-saved-items 1000
          ido-use-virtual-buffers t)

    (setq helm-adaptative-mode t
          helm-quick-update t
          helm-idle-delay 0.01
          helm-input-idle-delay 0.01
          helm-m-occur-idle-delay 0.01
          helm-exit-idle-delay 0.1
          helm-ls-git-status-command 'magit-status
          helm-candidate-number-limit 200
          helm-ff-search-library-in-sexp t
          helm-ff-file-name-history-use-recentf t
          helm-home-url "https://www.google.ca"
          helm-follow-mode-persistent t)

    (setf helm-C-x-b-sources (--remove (eq it 'helm-source-cmd-t) helm-C-x-b-sources)
          helm-C-x-b-sources (-insert-at 1 'helm-source-ido-virtual-buffers helm-C-x-b-sources)
          helm-C-x-b-sources (-insert-at 2 'helm-source-cmd-t helm-C-x-b-sources))

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
    ))


;; =============================================================
;; Multiple Cursors
;; =============================================================

;;; setup-multiple-cursors.el - install/configure multiple cursors.

(req-package multiple-cursors

  :bind
  (
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

   ;; Use left super as s-, build bindings off C-s-
   ("s-C-v s-C-v" . mc/edit-ends-of-lines)
   ("s-C-#"       . mc/insert-numbers)
   ("s-C-t"       . mc/mark-next-like-this)
   ("s-C-S-t"     . mc/mark-next-word-like-this)
   ("s-C-p"       . mc/mark-next-symbol-like-this)
   ("s-C-s"       . mc/mark-previous-like-this)
   ("s-C-S-s"     . mc/mark-previous-word-like-this)
   ("s-C-f"       . mc/mark-previous-symbol-like-this)

   ;; ### Mark many occurrences

   ("s-C-a"   . mc/mark-all-like-this)
   ("s-C-S-a" . mc/mark-all-words-like-this)
   ("s-C-q"   . mc/mark-all-symbols-like-this)

   ;; ### Mark all limited by key ->s-C-r (w) (x)
   ("s-C-r"   . mc/mark-all-in-region)
   ("s-C-w"   . mc/mark-all-like-this-in-defun)
   ("s-C-S-w" . mc/mark-all-words-like-this-in-defun)
   ("s-C-x"   . mc/mark-all-symbols-like-this-in-defun)

   ;; Mark all god keys
   ("M-m" . mc-expand-or-mark-next-symbol)
   ("M-M" . mc-expand-or-mark-next-word)
   ("M-'" . mc/mark-all-dwim))

  :init
  (progn

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

    )

  :config
  (progn
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

    ;; When running edit-lines, point will return (position + 1) as a
    ;; result of how evil deals with regions
    (defadvice mc/edit-lines (before change-point-by-1 activate)
      (if (> (point) (mark))
          (goto-char (1- (point)))
        (push-mark (1- (mark)))))

    (add-hook 'rectangular-region-mode-hook 'my-rrm-evil-switch-state)

    (defvar mc--default-cmds-to-run-once nil)))

;; =============================================================
;; paredit and smart parens
;; =============================================================

(req-package paredit
  :require (evil comment-dwim-2 hippie-expand)
  :init
  (let ((turn-on-paredit-mode (lambda () (paredit-mode 1))))
    ;; some hooks: lisp-mode-hook and scheme-mode-hook are recommended
    ;; in the paredit source code
    (--each '(lisp-mode-hook scheme-mode-hook emacs-lisp-mode-hook slime-mode-hook cider-repl-mode-hook)
      (add-hook it turn-on-paredit-mode)))

  :config
  (progn
    (defun kill-region-or-paredit-backward-kill-word ()
      (interactive)
      (if (region-active-p)
          (kill-region (region-beginning) (region-end))
        (call-interactively 'paredit-backward-kill-word)))

    (defadvice paredit-close-round (after paredit-close-and-indent activate)
      (cleanup-buffer))
    
    (bind-keys :map paredit-mode-map
               ("M-?" . hippie-expand-lines))

    (evil-declare-key 'insert paredit-mode-map
      (kbd "C-k") 'paredit-kill)

    (--each '(insert visual normal)
      (evil-declare-key it paredit-mode-map
        (kbd "C-w") 'kill-region-or-backward-word
        (kbd "M-;") 'comment-dwim-2))))

(req-package smartparens
  :require evil
  :init
  (progn
    (require 'smartparens-config)
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
    ;; Have to force some modes, as they are based on comint-mode
    (--each '(inferior-ess-mode-hook)
      (add-hook it 'smartparens-mode)))

  :config
  (progn

    ;; Laying paredit bindings on top of the smartparents one, not very
    ;; pretty but this includes all the functions that I want to use.
    (sp-use-smartparens-bindings)
    (sp-use-paredit-bindings)
    (setq-default sp-autoescape-string-quote nil)
    (setq-default sp-autoskip-closing-pair 'always)
    (setq-default sp-cancel-autoskip-on-backward-movement nil)

    ;; Fix smartparens-strict-mode-map for evil:
    (evil-define-key 'insert smartparens-strict-mode-map
      (kbd "DEL") #'sp-backward-delete-char)))

;; =============================================================
;; Visual Regexp
;; =============================================================
(req-package visual-regexp
  :require visual-regexp-steroids
  :bind (("M-%" . vr/select-query-replace)
         ("s-C-5" . vr/select-mc-mark)))

;; =============================================================
;; Expand Region
;; =============================================================

(req-package expand-region
  :bind (("C-'" . er/expand-region)
         ("C-\"" . er/contract-region)))

(req-package smart-forward
  :bind (("M-<up>" . smart-up)
         ("M-<down>" . smart-down)
         ("M-<left>" . smart-backward)
         ("M-<right>" . smart-forward)))

(req-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

;; =============================================================
;; Global keybindings
;; =============================================================

(bind-keys :map global-map
           ("M-j" . move-cursor-next-pane)
           ("M-k" . move-cursor-previous-pane)
           ("M-1" . delete-other-windows)
           ("M-!" . delete-window)
           ("M-2" . split-window-vertically)
           ("M-@" . split-window-horizontally)
           ("<f2>" . calc)
           ("<f4>" . mu4e)
           ("<f11>" . align-regexp)
           ("C-c a" . org-agenda)
           ("C-c b" . org-iswitchb)
           ("C-c e" . fc-eval-and-replace)
           ("C-ä" . magit-status)
           ("C-c o" . occur)
           ("C-c n" . cleanup-buffer)
           ;; Copy file path to kill ring
           ("C-x M-w" . copy-current-file-path)
           ;; Window switching
           ("C-x C--" . rotate-windows)
           ;; Revert without any fuss
           ("M-<escape>" (λ (revert-buffer t t)))
           ;; Eshell
           ("<M-return>" . new-line-dwim)
           ("M-RET" . new-line-dwim))

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
;; (kbd "M-V")

;; Note for the big rebind, M-e, and M-a should be off-limits, and are
;; pretty useful.

(global-unset-key (kbd "M-c"))

;; Capitalize
(bind-keys :prefix "M-c"
           :prefix-map caps-warp-map
           ("-" . snakeify-current-word)
           ("m" . replace-next-underscore-with-camel)
           ("c" . capitalize-word)
           ("l" . downcase-word)
           ("u" . upcase-word))

;; Transpose
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(bind-keys :prefix "M-t"
           :prefix-map transpose-map
           ("w" . transpose-words)
           ("s" . transpose-sexps)
           ("l" . transpose-lines)
           ("p" . transpose-params))

(bind-keys :prefix "C-x l"
           :prefix-map user-launch-map
           ("e" . esh))

;; View occurrence in occur mode
(req-package occur
  :config
  (progn
    (bind-keys :map occur-mode-map
               ("v" . occur-mode-display-occurrence)
               ("n" . next-line)
               ("p" . previous-line))))

(provide 'global-key-bindings)
