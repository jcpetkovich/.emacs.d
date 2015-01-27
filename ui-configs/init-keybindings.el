;; init-keybindings.el - Global keybindings, look here for cool stuff.

;; =============================================================
;; Ace Jump Mode
;; =============================================================

(req-package ace-jump-mode
  :require (evil dash)
  :commands (evil-ace-jump-word-mode evil-ace-jump-line-mode)
  :config
  (ace-jump-mode-enable-mark-sync))

(req-package ibuffer
  :config
  (progn
    (defadvice ace-jump-done (after ibuffer-ace-select activate)
      (if (eq major-mode 'ibuffer-mode)
          (ibuffer-visit-buffer)))))

(req-package ace-link
  :require ace-jump-mode
  :init (ace-link-setup-default))

;; =============================================================
;; Helm!
;; =============================================================

(req-package wgrep-helm
  :require helm)

(req-package helm-swoop
  :defer t
  :commands (helm-swoop helm-swoop-back-to-last-point helm-multi-swoop helm-multi-swoop-all)
  :init
  (progn
    (defun helm-swoop-custom (arg)
      "I don't want to have a query by default."
      (interactive "P")
      (if arg
          (helm-swoop :$multiline nil)
        (helm-swoop :$query "" :$multiline nil)))

    (bind-keys :map isearch-mode-map
               ("C-c m s" . helm-multi-swoop-all-from-isearch)
               ("C-c s" . helm-swoop-from-isearch))

    (bind-keys
     ("M-i"       . helm-swoop-custom)
     ("M-I"       . helm-swoop-back-to-last-point)
     ("C-c M-i"   . helm-multi-swoop)
     ("C-x M-i"   . helm-multi-swoop-all))))

(req-package helm-descbinds
  :bind ("C-h b" . helm-descbinds)
  :config (helm-descbinds-mode 1))

(req-package helm-proc
  :commands helm-proc)

(req-package helm-cmd-t
  :bind (("M-o" . helm-cmd-t)
         ("M-l" . helm-cmd-t-grep)
         ([remap list-buffers] . helm-C-x-b)
         ("C-x b" . helm-C-x-b)
         ("C-x C-b" . helm-C-x-b))

  :config
  (progn
    (unless helm-source-buffers-list
      (setq helm-source-buffers-list
            (helm-make-source "Buffers" 'helm-source-buffers)))
    (require 'helm-C-x-b)
    (setf helm-C-x-b-sources (--remove (eq it 'helm-source-cmd-t) helm-C-x-b-sources)
          helm-C-x-b-sources (-insert-at 1 'helm-source-recentf helm-C-x-b-sources))))

(req-package helm-company
  :require company
  :bind ("C-:" . helm-company))

(req-package helm-man
  :require helm
  :config (setq-default helm-man-or-woman-function 'woman))

(req-package helm-projectile
  :require (helm projectile)
  :config
  (progn
    (helm-projectile-on)))

(req-package helm
  :defer t
  :init
  (progn
    (require 'helm-config)
    (defun helm-do-grep-wrapper (arg)
      (interactive "P")
      (let ((current-prefix-arg (not arg)))
        (helm-do-grep)))

    (bind-keys
     ("M-x"       . helm-M-x)
     ("M-y"       . helm-show-kill-ring)
     ("C-x C-f"   . helm-find-files)
     ("C-c <SPC>" . helm-all-mark-rings)
     ("C-h r"     . helm-info-emacs)
     ("C-h d"     . helm-info-at-point)
     ("C-x C-d"   . helm-browse-project)
     ("C-h C-f"   . helm-apropos)
     ("C-h a"     . helm-apropos)
     ("M-v"       . helm-semantic-or-imenu)))

  :config
  (progn
    (require 'helm-tags)
    (require 'helm-regexp)
    (require 'helm-grep)
    (require 'helm-files)
    (defvar all-helm-maps '(helm-map
                            helm-etags-map
                            helm-moccur-map
                            helm-grep-map
                            helm-pdfgrep-map
                            helm-generic-files-map))


    (bind-keys :map helm-map
               ("C-i" . helm-execute-persistent-action)
               ("C-M-i" . helm-select-action))

    (bind-keys
     ("<f1>"                   . helm-resume)
     ([remap occur]            . helm-occur)
     ([remap jump-to-register] . helm-register)
     ([remap find-tag]         . helm-etags-select))

    (-each all-helm-maps
      (lambda (map)
        (eval `(bind-keys :map ,map
                          ("C-w" . user-utils/kill-region-or-backward-word)
                          ("M-w" . helm-yank-text-at-point)))))

    (bind-key "C-w" 'helm-find-files-up-one-level helm-find-files-map)

    ;; =============================================================
    ;; Helm Settings
    ;; =============================================================

    (helm-mode 1)
    (helm-adaptive-mode 1)

    (recentf-mode 1)
    (setq recentf-max-saved-items 1000
          ido-use-virtual-buffers t)

    (setq helm-quick-update t
          helm-idle-delay 0.01
          helm-input-idle-delay 0.01
          helm-m-occur-idle-delay 0.01
          helm-exit-idle-delay 0.1
          helm-candidate-number-limit 200
          helm-ff-search-library-in-sexp t
          helm-ff-file-name-history-use-recentf t
          helm-home-url "https://www.google.ca"
          helm-follow-mode-persistent t

          ;; fuzzy completion
          helm-M-x-fuzzy-match t
          helm-apropos-fuzzy-match t
          helm-buffers-fuzzy-matching t
          helm-lisp-fuzzy-completion t
          helm-recentf-fuzzy-match t)

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
        (error)))

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

(req-package multiple-cursors

  :bind
  (;; Use these keys (colemak layout):

   ;; | q | w | f | p |
   ;; |---+---+---+---|
   ;; | a | r | s | t |
   ;; |---+---+---+---|
   ;; | z | x | c | v |

   ;; Use left super as s-, build bindings off C-s-
   ("C-s-v C-s-v" . mc/edit-ends-of-lines)
   ("C-s-#"       . mc/insert-numbers)
   ("C-s-t"       . mc/mark-next-like-this)
   ("C-s-S-t"     . mc/mark-next-word-like-this)
   ("C-s-p"       . mc/mark-next-symbol-like-this)
   ("C-s-s"       . mc/mark-previous-like-this)
   ("C-s-S-s"     . mc/mark-previous-word-like-this)
   ("C-s-f"       . mc/mark-previous-symbol-like-this)

   ;; ### Mark many occurrences

   ("C-s-a"   . mc/mark-all-like-this)
   ("C-s-S-a" . mc/mark-all-words-like-this)
   ("C-s-q"   . mc/mark-all-symbols-like-this)

   ;; ### Mark all limited by key C-s-r (w) (x)
   ("C-s-r"   . mc/mark-all-in-region)
   ("C-s-w"   . mc/mark-all-like-this-in-defun)
   ("C-s-S-w" . mc/mark-all-words-like-this-in-defun)
   ("C-s-x"   . mc/mark-all-symbols-like-this-in-defun)

   ;; Mark all god keys
   ("M-m" . user-mc/expand-or-mark-next-symbol)
   ("M-M" . user-mc/expand-or-mark-next-word)
   ("M-'" . mc/mark-all-dwim)
   ("C-S-n" . mc/mmlte--down)
   ("C-S-p" . mc/mmlte--up)
   ("C-S-f" . mc/mmlte--right)
   ("C-S-b" . mc/mmlte--left))

  :config
  (progn
    (require 'mc-mark-more)

    ;; =============================================================
    ;; Custom multiple cursors functions
    ;; =============================================================
    (defun user-mc/expand-or-mark-next-symbol ()
      (interactive)
      (if (not (region-active-p))
          (er/mark-symbol)
        (let ((current-symbol (thing-at-point 'symbol))
              (current-region (car (mc/region-strings))))
          (if (string-equal current-symbol current-region)
              (call-interactively #'mc/mark-next-symbol-like-this)
            (call-interactively #'mc/mark-next-like-this)))))

    (defun user-mc/expand-or-mark-next-word ()
      (interactive)
      (if (not (region-active-p))
          (er/mark-word)
        (call-interactively #'mc/mark-next-like-this)))

    ;; Some "better" versions of emacs functionality don't work too
    ;; well in multiple cursors mode
    (bind-keys :map mc/keymap
               ("M-y" . yank-pop))

    ;; =============================================================
    ;; Multiple cursors evil compat (use emacs mode during mc)
    ;; =============================================================
    (defvar mc-evil-compat/evil-prev-state nil)
    (defvar mc-evil-compat/mark-was-active nil)

    (defun mc-evil-compat/switch-to-emacs-state ()
      (when (user-utils/evil-visual-or-normal-p)

        (setq mc-evil-compat/evil-prev-state evil-state)

        (when (region-active-p)
          (setq mc-evil-compat/mark-was-active t))

        (let ((mark-before (mark))
              (point-before (point)))

          (evil-emacs-state 1)

          (when (or mc-evil-compat/mark-was-active (region-active-p))
            (goto-char point-before)
            (set-mark mark-before)))))

    (defun mc-evil-compat/back-to-previous-state ()
      (when mc-evil-compat/evil-prev-state
        (unwind-protect
            (case mc-evil-compat/evil-prev-state
              ((normal visual) (evil-force-normal-state))
              (t (message "Don't know how to handle previous state: %S"
                          mc-evil-compat/evil-prev-state)))
          (setq mc-evil-compat/evil-prev-state nil)
          (setq mc-evil-compat/mark-was-active nil))))

    (add-hook 'multiple-cursors-mode-enabled-hook
              'mc-evil-compat/switch-to-emacs-state)
    (add-hook 'multiple-cursors-mode-disabled-hook
              'mc-evil-compat/back-to-previous-state)

    (defun mc-evil-compat/rectangular-switch-state ()
      (if rectangular-region-mode
          (mc-evil-compat/switch-to-emacs-state)
        (setq mc-evil-compat/evil-prev-state nil)))

    ;; When running edit-lines, point will return (position + 1) as a
    ;; result of how evil deals with regions
    (defadvice mc/edit-lines (before change-point-by-1 activate)
      (when (user-utils/evil-visual-or-normal-p)
        (if (> (point) (mark))
            (goto-char (1- (point)))
          (push-mark (1- (mark))))))

    (add-hook 'rectangular-region-mode-hook 'mc-evil-compat/rectangular-switch-state)

    (defvar mc--default-cmds-to-run-once nil)))

;; =============================================================
;; paredit and smart parens
;; =============================================================

(req-package paredit
  :commands (enable-paredit-mode paredit-mode)
  :init
  (progn
    (--each '(lisp-mode-hook
              scheme-mode-hook
              emacs-lisp-mode-hook
              slime-mode-hook
              clojure-mode-hook
              cider-repl-mode-hook)
      (add-hook it 'enable-paredit-mode)))

  :config
  (progn
    (require 'evil)
    (defun kill-region-or-paredit-backward-kill-word ()
      (interactive)
      (if (region-active-p)
          (call-interactively 'kill-region)
        (call-interactively 'paredit-backward-kill-word)))

    (defadvice paredit-close-round (after paredit-close-and-indent activate)
      (cleanup-buffer))

    (bind-keys :map paredit-mode-map
               ("M-?" . hippie-expand-lines))

    (evil-declare-key 'insert paredit-mode-map
      (kbd "C-k") 'paredit-kill)

    (--each '(insert visual normal)
      (evil-declare-key it paredit-mode-map
        (kbd "C-w") 'user-utils/kill-region-or-backward-word
        (kbd "M-;") 'comment-dwim-2))))

(req-package smartparens
  :require evil
  :commands (turn-on-smartparens-strict-mode smartparens-mode)
  :init
  (progn
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
              awk-mode-hook
              go-mode-hook
              rust-mode-hook
              elixir-mode-hook)
      (add-hook it 'turn-on-smartparens-strict-mode))
    ;; Have to force some modes, as they are based on comint-mode
    (--each '(inferior-ess-mode-hook)
      (add-hook it 'smartparens-mode)))

  :config
  (progn
    (require 'smartparens-config)
    (defun sp-c-like-pre-slurp-handler (id action context)
      (when (eq action 'slurp-forward)
        (save-excursion
          (when (and (= (sp-get ok :end) (sp-get next-thing :beg))
                     (equal (sp-get ok :op) (sp-get next-thing :op)))
            (goto-char (sp-get ok :end))
            (when (looking-back " ")
              (delete-char -1))))))
    (sp-local-pair '(latex-mode python-mode org-mode)
                   "(" nil
                   :pre-handlers '(sp-c-like-pre-slurp-handler))
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
  :bind (("M-%" . vr/select-query-replace)
         ("C-s-5" . vr/select-mc-mark)))


(req-package visual-regexp-steroids
  :require visual-regexp)

;; =============================================================
;; Expand Region
;; =============================================================

(req-package expand-region
  :require evil-leader
  :commands (er/mark-symbol er/mark-word)
  :bind (("C-'" . er/expand-region)
         ("C-\"" . er/contract-region))
  :init
  (progn
    (evil-leader/set-key "v" 'er/expand-region)
    (setq-default expand-region-fast-keys-enabled t
                  expand-region-contract-fast-key "V"
                  expand-region-reset-fast-key "r")))

(req-package smart-forward
  :bind (("M-<up>" . smart-up)
         ("M-<down>" . smart-down)
         ("M-<left>" . smart-backward)
         ("M-<right>" . smart-forward)))

(req-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

(req-package magnars-defuns
  :require (evil)
  :commands (cleanup-buffer
             copy-line
             open-line-above
             open-line-below
             rotate-windows
             copy-current-file-path)
  :bind (("C-c e" . eval-and-replace)
         ("<M-return>" . new-line-dwim)
         ("M-RET" . new-line-dwim))
  :config
  (progn
    (require 's)
    (bind-keys :map evil-insert-state-map
               ("C-w" . user-utils/kill-region-or-backward-word)
               ("C-k" . kill-line))

    (bind-keys :map evil-visual-state-map
               ("C-w" . user-utils/kill-region-or-backward-word))

    (defun copy-current-file-path ()
      "Add current file path to kill ring. Limits the filename to project root if possible."
      (interactive)
      (let ((filename (or (buffer-file-name) (buffer-name))))
        (kill-new (s-chop-prefix (projectile-project-p) filename))))))

(req-package shrink-whitespace
  :bind (("M-\\" . shrink-whitespace)
         ("M-n" . grow-whitespace-around)
         ("M-N" . shrink-whitespace-around))
  :config (require 's))

(req-package user-utils
  :commands user-utils/evil-visual-or-normal-p
  :bind (("C-w" . user-utils/kill-region-or-backward-word)
         ("M-w" . user-utils/save-region-or-current-line)
         ("M-j" . user-utils/move-cursor-next-pane)
         ("M-k" . user-utils/move-cursor-previous-pane)
         ("M-<escape>" . user-utils/force-revert))
  :config (require 's))

;; =============================================================
;; Global non-package related keys. (and list of good free keys)
;; =============================================================

(bind-keys
 ("M-1" . delete-other-windows)
 ("M-!" . delete-window)
 ("M-2" . split-window-vertically)
 ("M-@" . split-window-horizontally)
 ("<f7>" . compile)
 ("<f8>" . recompile)
 ("<f11>" . align-regexp)
 ("C-c u" . universal-argument))

;;; Unbound (or mostly useless) but convenientish keys
;; (kbd "M-p") ; usually bound during certain modes
;; (kbd "M-~")
;; (kbd "M-`")
;; (kbd "C-=")
;; (kbd "C-M-=")
;; (kbd "C-;")
;; (kbd "M-O")
;; (kbd "M-V")

;; =============================================================
;; User Prefix Keys
;; =============================================================

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

;; View occurrence in occur mode
(bind-keys :map occur-mode-map
           ("v" . occur-mode-display-occurrence)
           ("n" . next-line)
           ("p" . previous-line))

;; =============================================================
;; An evil leader, to guide us to ruin
;; =============================================================
(req-package pcre2el)
(req-package evil-leader
  :require evil
  :config
  (progn
    (global-evil-leader-mode 1)
    (setq-default evil-leader/in-all-states t
                  user-leader/prefix-command-string "group:")
    (evil-leader/set-leader "SPC" "C-S-")

    (defun user-leader/declare-prefix (prefix name)
      (let ((command (intern (concat user-leader/prefix-command-string name))))
        (define-prefix-command command)
        (evil-leader/set-key prefix command)))

    (evil-leader/set-key
      "SPC" 'evil-ace-jump-word-mode
      "!" 'shell-command)

    ;; Lead us to applications
    (user-leader/declare-prefix "a" "applications")
    (evil-leader/set-key
      "ac"  'calc-dispatch
      "ad"  'dired
      "ai"  'rcirc
      "ap"  'proced
      "am"  'emms-smart-browse
      "ase" 'esh
      "asi" 'shell
      "af"  'find-dired
      "ar"  'emr-show-refactor-menu
      "au"  'undo-tree-visualize
      "aw"  'helm-man-woman
      "ay"  'yas-insert-snippet)


    ;; Buffers
    (user-leader/declare-prefix "b" "buffer")
    (evil-leader/set-key
      "b0"  'beginning-of-buffer
      "b$"  'end-of-buffer
      "bc" 'cleanup-buffer
      "bK"  'kill-other-buffers
      "bk"  'kill-buffer
      "bn"  'switch-to-next-buffer
      "bp"  'switch-to-prev-buffer
      "bR"  'user-utils/force-revert
      "bb" 'eshell-insert-buffer-name
      "bw"  'toggle-read-only)

    (evil-leader/set-key "c" 'caps-warp-map)

    ;; errors
    (user-leader/declare-prefix "e" "errors")
    (evil-leader/set-key
      "en" 'next-error
      "ep" 'previous-error
      "efn" 'flycheck-next-error
      "efp" 'flycheck-previous-error)

    ;; Files
    (user-leader/declare-prefix "f" "files/directories")
    (evil-leader/set-key
      "ff" 'helm-find-files
      "fg" 'helm-do-grep-wrapper)
    (evil-leader/set-key
      "fj" 'dired-jump
      "fo" 'spacemacs/open-in-external-app
      "fS" 'evil-write-all
      "fs" 'evil-write
      "fy" 'copy-current-file-path)

    (user-leader/declare-prefix "g" "git/vc")
    (evil-leader/set-key
      "gs" 'magit-status)

    (user-leader/declare-prefix "h" "helm/help")
    (evil-leader/set-key
      "hdc" 'describe-char
      "hdf" 'describe-function
      "hdk" 'describe-key
      "hdm" 'describe-mode
      "hdp" 'describe-package
      "hdb" 'helm-descbinds
      "hdt" 'describe-theme
      "hdv" 'describe-variable)

    ;; Lead us to organization
    (user-leader/declare-prefix "l" "journal")
    (evil-leader/set-key
      "ll" 'user-org/open-todays-log
      "la" 'org-agenda
      "lc" 'org-capture)

    (user-leader/declare-prefix "m" "mode-specific")

    ;; Lead us to projects
    (user-leader/declare-prefix "p" "project")
    (evil-leader/set-key
      "pa" 'helm-projectile-ag
      "pA" 'helm-projectile-ack
      "pb" 'helm-projectile-switch-to-buffer
      "pd" 'helm-projectile-find-dir
      "pe" 'helm-projectile-recentf
      "pf" 'helm-projectile-find-file
      "pg" 'helm-projectile-grep
      "ph" 'helm-projectile
      "ps" 'helm-projectile-switch-project
      "pv" 'helm-projectile-vc)


    (user-leader/declare-prefix "q" "quit")
    (evil-leader/set-key
      "q s" 'save-buffers-kill-emacs
      "q q" 'save-buffers-kill-emacs)

    (user-leader/declare-prefix "R" "pcre2el")
    (evil-leader/set-key
      "R/"  'rxt-explain
      "Rc"  'rxt-convert-syntax
      "Rx"  'rxt-convert-to-rx
      "R'"  'rxt-convert-to-strings
      "Rpe" 'rxt-pcre-to-elisp
      "R%"  'pcre-query-replace-regexp
      "Rpx" 'rxt-pcre-to-rx
      "Rps" 'rxt-pcre-to-sre
      "Rp'" 'rxt-pcre-to-strings
      "Rp/" 'rxt-explain-pcre
      "Re/" 'rxt-explain-elisp
      "Rep" 'rxt-elisp-to-pcre
      "Rex" 'rxt-elisp-to-rx
      "Res" 'rxt-elisp-to-sre
      "Re'" 'rxt-elisp-to-strings
      "Ret" 'rxt-toggle-elisp-rx
      "Rt"  'rxt-toggle-elisp-rx
      "Rh"  'rxt-fontify-regexp-at-point)

    (user-leader/declare-prefix "r" "registers")
    (evil-leader/set-key
      "ry"  'helm-show-kill-ring
      "rr"  'helm-register
      "rm"  'helm-all-mark-rings)

    (user-leader/declare-prefix "s" "search")
    (evil-leader/set-key
      "sl" 'helm-semantic-or-imenu
      "sS" 'helm-multi-swoop
      "ss" 'helm-swoop)

    (evil-leader/set-key "u" 'universal-argument)

    ;; Lead us to windows
    (user-leader/declare-prefix "w" "window")

    (user-leader/declare-prefix "wp" "windows-popup")
    (user-leader/declare-prefix "wS" "windows-size")

    (evil-leader/set-key
      "w2"  'layout-double-columns
      "w3"  'layout-triple-columns
      "wc"  'delete-window
      "wC"  'delete-other-windows
      "wd"  'toggle-current-window-dedication
      "wH"  'evil-window-move-far-left
      "wh"  'evil-window-left
      "wJ"  'evil-window-move-very-bottom
      "wj"  'evil-window-down
      "wK"  'evil-window-move-very-top
      "wk"  'evil-window-up
      "wL"  'evil-window-move-far-right
      "wl"  'evil-window-right
      "wM"  'toggle-maximize-centered-buffer
      "wm"  'toggle-maximize-buffer
      "wo"  'other-frame
      "wr" 'rotate-windows
      "wR"  'rotate-windows
      "ws"  'split-window-below
      "wS"  'split-window-below-and-focus
      "w-"  'split-window-below
      "wU"  'winner-redo
      "wu"  'winner-undo
      "wv"  'split-window-right
      "wV"  'split-window-right-and-focus
      "w/"  'split-window-right
      "ww"  'other-window
      "wpm" 'popwin:messages
      "wpp" 'popwin:close-popup-window)

    (user-leader/declare-prefix "x" "text")
    (user-leader/declare-prefix "xd" "text-delete")
    (user-leader/declare-prefix "xm" "text-move")
    (user-leader/declare-prefix "xt" "text-transpose")
    (user-leader/declare-prefix "xw" "text-words")

    (evil-leader/set-key
      "xdw" 'delete-trailing-whitespace
      "xtc" 'transpose-chars
      "xtl" 'transpose-lines
      "xtw" 'transpose-words
      "xtp" 'transpose-params
      "xts" 'transpose-sexps
      "xU"  'upcase-region
      "xu"  'downcase-region
      "xwC" 'count-words-analysis
      "xwc" 'count-words-region
      "xmj" 'move-text-down
      "xmk" 'move-text-up)

    (evil-leader/set-key
      "/" 'helm-cmd-t-grep)))

;; TODO:

;; packages.el:32:      '(evil-leader/set-key-for-mode 'scss-mode "mgh" 'helm-css-scss))))
;; packages.el:58:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "m" "major mode")
;; packages.el:60:      (evil-leader/set-key-for-mode 'js2-mode "mw" 'js2-mode-toggle-warnings-and-errors)
;; packages.el:62:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mz" "folding")
;; packages.el:63:      (evil-leader/set-key-for-mode 'js2-mode "mzc" 'js2-mode-hide-element)
;; packages.el:64:      (evil-leader/set-key-for-mode 'js2-mode "mzo" 'js2-mode-show-element)
;; packages.el:65:      (evil-leader/set-key-for-mode 'js2-mode "mzr" 'js2-mode-show-all)
;; packages.el:66:      (evil-leader/set-key-for-mode 'js2-mode "mze" 'js2-mode-toggle-element)
;; packages.el:67:      (evil-leader/set-key-for-mode 'js2-mode "mzF" 'js2-mode-toggle-hide-functions)
;; packages.el:68:      (evil-leader/set-key-for-mode 'js2-mode "mzC" 'js2-mode-toggle-hide-comments))))
;; packages.el:81:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mr" "refactor")
;; packages.el:83:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mr3" "ternary")
;; packages.el:84:      (evil-leader/set-key-for-mode 'js2-mode "mr3i" 'js2r-ternary-to-if)
;; packages.el:86:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mra" "add/args")
;; packages.el:87:      (evil-leader/set-key-for-mode 'js2-mode "mrag" 'js2r-add-to-globals-annotation)
;; packages.el:88:      (evil-leader/set-key-for-mode 'js2-mode "mrao" 'js2r-arguments-to-object)
;; packages.el:90:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrb" "barf")
;; packages.el:91:      (evil-leader/set-key-for-mode 'js2-mode "mrba" 'js2r-forward-barf)
;; packages.el:93:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrc" "contract")
;; packages.el:94:      (evil-leader/set-key-for-mode 'js2-mode "mrca" 'js2r-contract-array)
;; packages.el:95:      (evil-leader/set-key-for-mode 'js2-mode "mrco" 'js2r-contract-object)
;; packages.el:96:      (evil-leader/set-key-for-mode 'js2-mode "mrcu" 'js2r-contract-function)
;; packages.el:98:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mre" "expand/extract")
;; packages.el:99:      (evil-leader/set-key-for-mode 'js2-mode "mrea" 'js2r-expand-array)
;; packages.el:100:      (evil-leader/set-key-for-mode 'js2-mode "mref" 'js2r-extract-function)
;; packages.el:101:      (evil-leader/set-key-for-mode 'js2-mode "mrem" 'js2r-extract-method)
;; packages.el:102:      (evil-leader/set-key-for-mode 'js2-mode "mreo" 'js2r-expand-object)
;; packages.el:103:      (evil-leader/set-key-for-mode 'js2-mode "mreu" 'js2r-expand-function)
;; packages.el:104:      (evil-leader/set-key-for-mode 'js2-mode "mrev" 'js2r-extract-var)
;; packages.el:106:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mri" "inline/inject/introduct")
;; packages.el:107:      (evil-leader/set-key-for-mode 'js2-mode "mrig" 'js2r-inject-global-in-iife)
;; packages.el:108:      (evil-leader/set-key-for-mode 'js2-mode "mrip" 'js2r-introduce-parameter)
;; packages.el:109:      (evil-leader/set-key-for-mode 'js2-mode "mriv" 'js2r-inline-var)
;; packages.el:111:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrl" "localize/log")
;; packages.el:112:      (evil-leader/set-key-for-mode 'js2-mode "mrlp" 'js2r-localize-parameter)
;; packages.el:113:      (evil-leader/set-key-for-mode 'js2-mode "mrlt" 'js2r-log-this)
;; packages.el:115:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrr" "rename")
;; packages.el:116:      (evil-leader/set-key-for-mode 'js2-mode "mrrv" 'js2r-rename-var)
;; packages.el:118:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrs" "split/slurp")
;; packages.el:119:      (evil-leader/set-key-for-mode 'js2-mode "mrsl" 'js2r-forward-slurp)
;; packages.el:120:      (evil-leader/set-key-for-mode 'js2-mode "mrss" 'js2r-split-string)
;; packages.el:121:      (evil-leader/set-key-for-mode 'js2-mode "mrsv" 'js2r-split-var-declaration)
;; packages.el:123:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrt" "toggle")
;; packages.el:124:      (evil-leader/set-key-for-mode 'js2-mode "mrtf" 'js2r-toggle-function-expression-and-declaration)
;; packages.el:126:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mru" "unwrap")
;; packages.el:127:      (evil-leader/set-key-for-mode 'js2-mode "mruw" 'js2r-unwrap)
;; packages.el:129:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrv" "var")
;; packages.el:130:      (evil-leader/set-key-for-mode 'js2-mode "mrvt" 'js2r-var-to-this)
;; packages.el:132:      ;;(spacemacs/declare-prefix-for-mode 'js2-mode "mrw" "wrap")
;; packages.el:133:      (evil-leader/set-key-for-mode 'js2-mode "mrwi" 'js2r-wrap-buffer-in-iife)
;; packages.el:134:      (evil-leader/set-key-for-mode 'js2-mode "mrwl" 'js2r-wrap-in-for-loop)
;; packages.el:136:      (evil-leader/set-key-for-mode 'js2-mode "mk" 'js2r-kill)
;; packages.el:150:      (evil-leader/set-key-for-mode 'js2-mode "mc" 'tern-rename-variable)
;; packages.el:151:      (evil-leader/set-key-for-mode 'js2-mode "mhd" 'tern-get-docs)
;; packages.el:152:      (evil-leader/set-key-for-mode 'js2-mode "mgg" 'tern-find-definition)
;; packages.el:153:      (evil-leader/set-key-for-mode 'js2-mode "mgG" 'tern-find-definition-by-name)
;; packages.el:154:      (evil-leader/set-key-for-mode 'js2-mode (kbd "m C-g") 'tern-pop-find-definition)
;; packages.el:155:      (evil-leader/set-key-for-mode 'js2-mode "mt" 'tern-get-type))))
;; packages.el:17:      (evil-leader/set-key-for-mode 'lua-mode "md" 'lua-search-documentation)
;; packages.el:18:      (evil-leader/set-key-for-mode 'lua-mode "msb" 'lua-send-buffer)
;; packages.el:19:      (evil-leader/set-key-for-mode 'lua-mode "msf" 'lua-send-defun)
;; packages.el:20:      (evil-leader/set-key-for-mode 'lua-mode "msl" 'lua-send-current-line)
;; packages.el:21:      (evil-leader/set-key-for-mode 'lua-mode "msr" 'lua-send-region))))
;; packages.el:28:        "m{" 'beginning-of-defun
;; packages.el:29:        "m}" 'end-of-defun
;; packages.el:30:        "m$" 'puppet-interpolate
;; packages.el:31:        "ma" 'puppet-align-block
;; packages.el:32:        "m'" 'puppet-toggle-string-quotes
;; packages.el:33:        "m;" 'puppet-clear-string
;; packages.el:34:        "mj" 'imenu
;; packages.el:35:        "mc" 'puppet-apply
;; packages.el:36:        "mv" 'puppet-validate
;; packages.el:37:        "ml" 'puppet-lint
;; packages.el:49:    :config (progn (evil-leader/set-key-for-mode 'enh-ruby-mode "mgg" 'robe-jump)
;; packages.el:50:                   (evil-leader/set-key-for-mode 'enh-ruby-mode "mhd" 'robe-doc)
;; packages.el:51:                   (evil-leader/set-key-for-mode 'enh-ruby-mode "mR" 'robe-rails-refresh)
;; packages.el:52:                   (evil-leader/set-key-for-mode 'enh-ruby-mode "mi" 'robe-start))))
;; packages.el:70:    :config (progn (evil-leader/set-key "mtb" 'ruby-test-run)
;; packages.el:71:                   (evil-leader/set-key "mtt" 'ruby-test-run-at-point))))
;; packages.el:45:        (kbd "M-n") 'forward-button
;; packages.el:46:        (kbd "M-p") 'backward-button
;; extensions.el:38:      "mhD" 'dos-help-cmd
;; extensions.el:39:      "meb" 'dos-run
;; extensions.el:40:      "meB" 'dos-run-args
;; extensions.el:41:      "ms"  'dos-sep
;; extensions.el:42:      "mt"  'dos-template-mini
;; extensions.el:43:      "mT"  'dos-template
;; extensions.el:44:      "mz"  'windows-scripts/dos-outline)))
;; dos.el:30:;;      (add-to-list 'load-path "mypath/dos")
;; dos.el:51:;; 22 Jan 2013  2.18 Moved keywords "mkdir" and "rmdir" from `font-lock-warning-face' to `font-lock-builtin-face'.
;; dos.el:88:(defgroup dos nil "Major mode for editing Dos scripts." :tag "Dos" :group 'languages)
;; dos.el:112:             "doskey"   "echo"     "endlocal" "erase"    "exist"    "fc"       "find"     "md"       "mkdir"    "more"
;; dos.el:113:             "move"     "path"     "pause"    "popd"     "prompt"   "pushd"    "ren"      "rd"       "rmdir"    "set"
;; dos.el:119:           '("cat"      "cp"       "ls"       "mv"       "rm")))
;; dos.el:139:    ["Mini Template" dos-template-mini] ; :help "Insert minimal template"
;; dos.el:235:(defun dos-mode () "Major mode for editing Dos scripts.\n
;; packages.el:19:        "ms" 'restclient-http-send-current-stay-in-window
;; packages.el:20:        "mS" 'restclient-http-send-current
;; packages.el:21:        "mr" 'restclient-http-send-current-raw-stay-in-window
;; packages.el:22:        "mR" 'restclient-http-send-current-raw
;; packages.el:49:      (evil-leader/set-key "m:" 'spacemacs/smex-major-mode-commands)
;; packages.el:50:      (global-set-key (kbd "M-x") 'smex)
;; packages.el:51:      (global-set-key (kbd "M-X") 'smex)
;; packages.el:61:        "ml" 'evil-lisp-state
;; packages.el:62:        "mt" 'racket-test
;; packages.el:63:        "mg" 'racket-visit-definition
;; packages.el:64:        "mhd" 'racket-doc)
;; packages.el:29:      "mgg" 'ycmd-goto
;; packages.el:30:      "mgG" 'ycmd-goto-imprecise)))
;; configuration-layer.el:20:                           ("melpa" . "http://melpa.org/packages/")))
;; configuration-layer.el:28:                 '("marmalade" . "http://marmalade-repo.org/packages/")))
;; dotspacemacs.el:39:  "Major mode leader key is a shortcut key which is the equivalent of
;; spacemacs-mode.el:26:(defconst spacemacs-checkversion-branch "master"
;; spacemacs-mode.el:463:  (insert-button "Messages Buffer" 'action (lambda (b) (switch-to-buffer "*Messages*")) 'follow-link t)
;; init.el:13:(defconst spacemacs-min-version   "24.3" "Mininal required version of Emacs.")
;; centered-cursor-mode.el:99:  "Makes the cursor stay vertically in a defined position (usually centered).
;; centered-cursor-mode.el:389:  "Makes the cursor stay vertically in a defined
;; evil-escape.el:78:    "Max time delay between the two key press to be considered successful."
;; evil-escape.el:167:                     (cond ((string-match "magit" (symbol-name major-mode))
;; evil-escape.el:189:    (eval `(evil-escape-define-escape "motion-state" evil-motion-state-map ,exit-func
;; evil-escape.el:192:  (eval `(evil-escape-define-escape "minibuffer" minibuffer-local-map abort-recursive-edit
;; evil-lisp-state.el:150:  (defcustom evil-lisp-state-leader-prefix "m"
;; evil-lisp-state.el:156:    "Major modes where evil leader key bindings are defined."
;; evil-lisp-state.el:193:  (evil-leader/set-key-for-mode mm "me$" 'lisp-state-eval-sexp-end-of-line)
;; evil-lisp-state.el:194:  (evil-leader/set-key-for-mode mm "mee" 'eval-last-sexp)
;; evil-lisp-state.el:195:  (evil-leader/set-key-for-mode mm "mef" 'eval-defun)
;; evil-lisp-state.el:196:  (evil-leader/set-key-for-mode mm "mgg" 'elisp-slime-nav-find-elisp-thing-at-point)
;; evil-lisp-state.el:197:  (evil-leader/set-key-for-mode mm "mhh" 'elisp-slime-nav-describe-elisp-thing-at-point)
;; evil-lisp-state.el:198:  (evil-leader/set-key-for-mode mm "m,"  'lisp-state-toggle-lisp-state)
;; evil-lisp-state.el:199:  (evil-leader/set-key-for-mode mm "mtb" 'spacemacs/ert-run-tests-buffer)
;; evil-lisp-state.el:200:  (evil-leader/set-key-for-mode mm "mtq" 'ert))
;; evil-lisp-state.el:230:    ("m"   . sp-join-sexp)
;; evil-tutor.el:40:  "Major mode for evil-tutor.")
;; evil-tutor.el:95:  "Move the next lesson.
;; evil-tutor.el:115:  "Move to the previous lession.
;; paradox.el:374:  "Major mode for browsing a list of packages.
;; paradox.el:453:  "Move to previous entry, which might not be the previous line.
;; paradox.el:461:  "Move to next entry, which might not be the next line.
;; paradox.el:471:  "Move to the next package and describe it.
;; paradox.el:478:  "Move to the previous package and describe it.
;; paradox.el:1279:  "Max number of pages we read from github when fetching the commit-list.
;; paradox.el:1438:  "Move to previous commit, which might not be the previous line.
;; paradox.el:1444:  "Move to next commit, which might not be the next line.
;; paradox.el:1455:  "Major mode for browsing a list of commits.
;; paradox.el:1462:          ("Message" 0 nil)])
;; rcirc-reconnect.el:60:;;            process "my-rcirc.el" "ERROR" rcirc-target
;; rcirc-reconnect.el:83:;;             (rcirc-print process "my-rcirc.el" "ERROR" rcirc-target
;; rcirc-reconnect.el:94:;;              (rcirc-print process "my-rcirc.el" "ERROR" rcirc-target
;; solarized.el:54:  "Make the fringe background different from the normal background color.
;; solarized.el:80:  "Make the active/inactive mode line stand out more."
;; frame-cmds.el:226:;;       :help "Maximize or restore the selected frame vertically"
;; frame-cmds.el:230:;;       :help "Maximize or restore the selected frame horizontally"
;; frame-cmds.el:234:;;       :help "Maximize or restore the selected frame (in both directions)"
;; frame-cmds.el:237:;;     '(menu-item "Maximize Frame Vertically" maximize-frame-vertically
;; frame-cmds.el:238:;;       :help "Maximize the selected frame vertically"))
;; frame-cmds.el:240:;;     '(menu-item "Maximize Frame Horizontally" maximize-frame-horizontally
;; frame-cmds.el:241:;;       :help "Maximize the selected frame horizontally"))
;; frame-cmds.el:243:;;     '(menu-item "Maximize Frame" maximize-frame
;; frame-cmds.el:244:;;       :help "Maximize the selected frame (in both directions)"))
;; frame-cmds.el:578:  "Miscellaneous frame and window commands."
;; frame-cmds.el:582:          ,(concat "mailto:" "drew.adams" "@" "oracle" ".com?subject=\
;; frame-cmds.el:1081:  "Make FRAME visible and raise it, without selecting it.
;; frame-cmds.el:1090:  "Make FRAME invisible.  Like `make-frame-invisible', but reads frame name.
;; frame-cmds.el:1097:  "Make visible and raise a frame showing BUFFER, if there is one.
;; frame-cmds.el:1141:  "Maximize selected frame horizontally."
;; frame-cmds.el:1147:  "Maximize selected frame vertically."
;; frame-cmds.el:1153:  "Maximize selected frame horizontally, vertically, or both.
;; frame-cmds.el:1522:    "Modifies LIST to remove the last N elements."
;; frame-cmds.el:1595:  "Move selected frame down.
;; frame-cmds.el:1605:  "Move selected frame up.
;; frame-cmds.el:1613:  "Move frame to the right.
;; frame-cmds.el:1623:  "Move frame to the left.
;; frame-cmds.el:1648:  "Move FRAME (default: selected-frame) to the top of the screen.
;; frame-cmds.el:1658:  "Move FRAME (default: selected-frame) to the bottom of the screen.
;; frame-cmds.el:1678:  "Move FRAME (default: selected-frame) to the left side of the screen.
;; frame-cmds.el:1688:  "Move FRAME (default: selected-frame) to the right side of the screen.
;; frame-cmds.el:1700:  "Move FRAME (default: selected-frame) to the top and left of the screen.
;; frame-cmds.el:1905:                   ("menu-bar-lines")
;; frame-cmds.el:1906:                   ("minibuffer")
;; frame-cmds.el:1907:                   ("mouse-color")
;; zoom-frm.el:219:          ,(concat "mailto:" "drew.adams" "@" "oracle" ".com?subject=\
;; zoom-frm.el:314:          (if (string-match "mouse" (format "%S" (event-basic-type
;; zoom-frm.el:331:          (if (string-match "mouse" (format "%S" (event-basic-type
;; zoom-frm.el:390:                (if (string-match "mouse" (format "%S" (event-basic-type last-command-event)))
;; funcs.el:98:    (setq major-mode-map (lookup-key mode-map (kbd "m")))
;; funcs.el:214:  "Maximize buffer"
;; funcs.el:223:  "Maximize buffer and center it on the screen"
;; funcs.el:666:  "Minor mode to use big fringe in the current buffer."
;; keybindings.el:20:(define-key isearch-mode-map (kbd "M-S-<return>") 'isearch-repeat-backward)
;; packages.el:1190:        (evil-leader/set-key-for-mode 'eshell-mode "mH" 'spacemacs/helm-eshell-history))
;; packages.el:1193:      (evil-leader/set-key-for-mode 'shell-mode "mH" 'spacemacs/helm-shell-history)
;; packages.el:1339:        "mhd" 'ledger-delete-current-transaction
;; packages.el:1340:        "ma"  'ledger-add-transaction))))
;; packages.el:1491:        "mc" 'org-capture
;; packages.el:1492:        "md" 'org-deadline
;; packages.el:1493:        "me" 'org-export-dispatch
;; packages.el:1494:        "mi" 'org-clock-in
;; packages.el:1495:        "mo" 'org-clock-out
;; packages.el:1496:        "mm" 'org-ctrl-c-ctrl-c
;; packages.el:1497:        "mr" 'org-refile
;; packages.el:1498:        "ms" 'org-schedule)
;; packages.el:1503:           "a" nil "ma" 'org-agenda
;; packages.el:1504:           "c" nil "mA" 'org-archive-subtree
;; packages.el:1505:           "o" nil "mC" 'evil-org-recompute-clocks
;; packages.el:1506:           "l" nil "ml" 'evil-org-open-links
;; packages.el:1507:           "t" nil "mt" 'org-show-todo-tree)))
;; packages.el:1606:                      'help-echo "Minor mode\n mouse-1: Display minor mode menu\n mouse-2: Show help for minor mode\n mouse-3: Toggle minor modes"


(provide 'init-keybindings)
