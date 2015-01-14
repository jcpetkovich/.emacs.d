;; init-keybindings.el - Global keybindings, look here for cool stuff.

;; =============================================================
;; Ace Jump Mode
;; =============================================================

(req-package ace-jump-mode
  :require (evil dash)
  :commands (evil-ace-jump-word-mode evil-ace-jump-line-mode)
  :init
  (progn
    (--each '(normal visual movement)
      (evil-declare-key it global-map
        (kbd "SPC") 'evil-ace-jump-word-mode
        (kbd "C-SPC") 'evil-ace-jump-line-mode)))
  :config
  (progn

    (ace-jump-mode-enable-mark-sync)))

(req-package ibuffer
  :config
  (progn
    (bind-key "SPC" 'ace-jump-mode ibuffer-mode-map)
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
  :commands (er/mark-symbol er/mark-word)
  :bind (("C-'" . er/expand-region)
         ("C-\"" . er/contract-region)))

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

;; Launch
(global-unset-key (kbd "C-l"))
(bind-keys :prefix "C-l"
           :prefix-map user-launch-map
           ("=" . calc)
           ("a" . org-agenda)
           ("c" . org-capture)
           ("e" . esh)
           ("f" . find-dired)
           ("g" . helm-do-grep-wrapper)
           ("l" . user-org/open-todays-log)
           ("m" . magit-status)
           ("p" . emms-smart-browse)
           ("r" . emr-show-refactor-menu)
           ("s" . shell)
           ("t" . term)
           ("w" . helm-man-woman)
           ("y" . yas-insert-snippet))

;; User run
(bind-keys :prefix "M-u"
           :prefix-map user-run-map
           ("c b" . cleanup-buffer)
           ("h" . helm-command-prefix)
           ("M-w" . copy-current-file-path)
           ("r" . rotate-windows)
           ("b" . eshell-insert-buffer-name)
           ("f" . flycheck-next-error))

;; View occurrence in occur mode
(bind-keys :map occur-mode-map
           ("v" . occur-mode-display-occurrence)
           ("n" . next-line)
           ("p" . previous-line))

(provide 'init-keybindings)