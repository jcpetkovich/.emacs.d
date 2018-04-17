;;; packages.el --- Personal Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Jean-Christophe Petkovich
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq personal-packages
      '(
        auctex
        autopair
        browse-url
        comment-dwim-2
        company
        company-quickhelp
        dash
        dired-rainbow
        emms
        ess
        emr
        evil
        go-mode
        helm
        helm-swoop
        magit
        markdown-mode
        paradox
        paredit
        prodigy
        shrink-whitespace
        whitespace-cleanup-mode
        yasnippet
        js2-mode
        helm-pass
        writeroom-mode
        slack
        ranger
        polymode
        web-mode
        zoom-frm
        evil-mc
        evil-mc-extras

        (simple :location built-in)
        (recentf :location built-in)
        (hippie-expand :location built-in)
        (dired :location built-in)
        (wdired :location built-in)
        (doc-view :location built-in)
        )
      )

(setq personal-excluded-packages '())
(defvar secrets-loaded nil)

;; just set them
(setq user-full-name "Jean-Christophe Petkovich")

;; use-package hooks
(spacemacs|use-package-add-hook smartparens
  :post-config
  (progn
    (show-smartparens-global-mode -1)))

(defun personal/appearance-configs ()
  (setq-default
   mouse-wheel-scroll-amount '(1)
   scroll-conservatively     100000
   show-paren-style          'expression
   display-time-day-and-date nil
   display-time-24hr-format  nil

   frame-title-format
   (list
    '(:eval (cond (buffer-file-name
                   (buffer-file-name))
                  (dired-directory
                   dired-directory)
                  (t
                   (buffer-name)))))))

(defun personal/editing-configs ()
  (setq-default
   ;; Editing
   indent-tabs-mode            nil
   sentence-end-double-space   nil
   uniquify-buffer-name-style  'post-forward
   lpr-command                 "xpp"
   tags-revert-without-query   t
   tags-table-list             nil
   ediff-window-setup-function 'ediff-setup-windows-plain
   ido-use-virtual-buffers     t

   ;; Backups
   backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
   make-backup-files      t
   vc-make-backup-files   t

   ;; Copy and Paste
   x-select-enable-clipboard           t
   x-select-enable-primary             t
   save-interprogram-paste-before-kill t
   mouse-yank-at-point                 t))

(defun personal/org-mode-configs ()
  (use-package evil-org
    :commands evil-org-mode
    :config
    (--each '(insert normal)
      (evil-declare-key it evil-org-mode-map
        (kbd "M-k") 'personal/move-cursor-previous-pane
        (kbd "M-j") 'personal/move-cursor-next-pane))))

(defun personal/spacemacs-configs ())

(defun load-secrets ()
  (when (not secrets-loaded)
    (load (concat dotspacemacs-directory "secrets.el.gpg"))
    (setq secrets-loaded t)))

(defun personal/post-init-paradox ()
  (use-package paradox
    :defer t
    :config
    (load-secrets)))

(defun personal/helm-configs ()

  (setq helm-locate-command "locate %s -e -A --regex %s")

  (bind-keys
   ("M-o" . helm-projectile-find-file))

  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-motion-state-map (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-visual-state-map (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-insert-state-map (kbd "C-p") 'helm-projectile-find-file)

  (use-package helm
    :defer t
    :config
    (bind-keys :map helm-map
               ("<escape>" . spacemacs/helm-navigation-micro-state)
               ("C-i" . helm-execute-persistent-action)
               ("<tab>" . helm-execute-persistent-action)
               ("C-M-i" . helm-select-action)))

  (evil-leader/set-key
    "o"  'helm-mini))

(defun personal/keybinding-configs ()

  (defun annoying ()
    (interactive)
    (message "Try something else"))

  (bind-keys
   ("C-x C-f" . annoying)
   ("C-x C-b" . annoying)
   ("C-x b" . annoying)
   ("C-x C-s" . annoying)
   ("C-x k" . annoying)))

(defadvice dotspacemacs/user-config (before personal-vars activate)
  "Overriding spacemacs and other layer defaults."
  (personal/appearance-configs)
  (personal/editing-configs)
  (personal/spacemacs-configs)
  (personal/helm-configs)
  (personal/org-mode-configs)
  (personal/keybinding-configs))

(defun personal/init-autopair ()
  (use-package autopair
    :defer t))

(defun personal/post-init-auctex ()

  (use-package latex
    :defer t
    :config
    (bind-keys :map LaTeX-mode-map
               ("<M-return>" . LaTeX-insert-item)))

  (use-package tex
    :defer t
    :config
    (progn

      (setq-default LaTeX-beamer-item-overlay-flag nil)

      (spacemacs/set-leader-keys-for-major-mode 'latex-mode
        "d" 'personal/tex-delete-env-pair)


      (add-hook 'LaTeX-mode-hook 'reftex-mode)
      (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
      (setq LaTeX-mode-hook (append LaTeX-mode-hook '(personal/tex-noweb-noflycheck)))

      (push '("zathura" "zathura -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf")
            TeX-view-program-list)
      (push '(output-pdf "zathura")
            TeX-view-program-selection)

      (add-hook 'bibtex-mode-hook (defun personal/disable-smartparens-show ()
                                    (show-smartparens-mode -1)))

      (defun personal/tex-check-item-entry ()
        "This function is meant to be used as advice for the
`LaTeX-insert-item' function. The purpose behind this is to delete
the extra blank line that is naively added by `LaTeX-insert-item'
when not already on an item line."
        (interactive)
        (save-excursion
          ;; Backward one line, check if it happened if the line we're
          ;; looking is empty, delete it
          (if (and (= (forward-line -1) 0)
                   (looking-at "^\\s-*$"))
              (kill-line))))

      (defadvice LaTeX-insert-item (after remove-whitespace-first-item activate)
        "This advice is meant to fix the issue where an extra blank
line is naively added by `LaTeX-insert-item' when not already on
an item line."
        (personal/tex-check-item-entry))

      (defun personal/tex-delete-env-pair ()
        "Deletes the \begin{} \end{} pair at point."
        (interactive)
        (save-excursion
          (beginning-of-line)
          (if (looking-at "\s*\\\\end")
              (progn
                (save-excursion
                  (LaTeX-find-matching-begin)
                  (beginning-of-line)
                  (kill-line)))
            (if (looking-at "\s*\\\\begin")
                (progn
                  (save-excursion
                    (end-of-line)
                    (LaTeX-find-matching-end)
                    (beginning-of-line)
                    (kill-line)))))
          (beginning-of-line)
          (kill-line))))))

(defun personal/post-init-markdown-mode ()
  (use-package markdown-mode
    :defer
    :bind (:map markdown-mode-map
                ("M-k" . personal/move-cursor-previous-pane)
                ("M-j" . personal/move-cursor-next-pane))))

(defun personal/post-init-helm ()
  (use-package helm
    :defer t
    :config
    (progn
      (require 'helm-tags)
      (require 'helm-regexp)
      (require 'helm-grep)
      (require 'helm-files)
      (require 'helm-man)

      (defvar all-helm-maps '(helm-map
                              helm-etags-map
                              helm-moccur-map
                              helm-grep-map
                              helm-pdfgrep-map
                              helm-generic-files-map))

      (bind-keys
       ("<f1>"                   . helm-resume))

      (-each all-helm-maps
        (lambda (map)
          (eval `(bind-keys :map ,map
                            ("C-w" . personal/kill-region-or-backward-word)
                            ("M-w" . helm-yank-text-at-point)))))

      (bind-key "C-w" 'helm-find-files-up-one-level helm-find-files-map)

      ;; =============================================================
      ;; Hack to fix rare error from helm--maybe-update-keymap
      ;; =============================================================
      ;; (defun helm--maybe-update-keymap ()
      ;;         "Handle differents keymaps in multiples sources.

      ;; It will override `helm-map' with the local map of current source.
      ;; If no map is found in current source do nothing (keep previous map)."
      ;;         (condition-case err
      ;;             (progn
      ;;               (with-helm-buffer
      ;;                 (helm-aif (assoc-default 'keymap (helm-get-current-source))
      ;;                     ;; Fix #466; we use here set-transient-map
      ;;                     ;; to not overhide other minor-mode-map's.
      ;;                     (if (fboundp 'set-transient-map)
      ;;                         (set-transient-map it)
      ;;                       (set-temporary-overlay-map it)))))
      ;;           (error)))
      )))

(defun personal/pre-init-evil ()
  "Set evil vars before evil loads."
  (setq-default evil-symbol-word-search t
                evil-cross-lines t
                evil-esc-delay 0))

(defun personal/post-init-paredit ()
  (use-package paredit
    :defer t
    :config
    (progn
      (bind-keys :map paredit-mode-map
                 ("M-?" . hippie-expand-lines))
      (defadvice paredit-close-round (after paredit-close-and-indent activate)
        (personal/cleanup-buffer))

      (--each '(insert visual normal)
        (evil-declare-key it paredit-mode-map
          (kbd "M-;") 'comment-dwim-2))
      (--each '(insert visual)
        (evil-declare-key it paredit-mode-map
          (kbd "M-w") 'personal/save-region-or-current-line
          (kbd "C-w") 'personal/kill-region-or-backward-word)))))

(defun personal/init-comment-dwim-2 ()
  (use-package comment-dwim-2
    :commands comment-dwim-2
    :init
    (progn
      (bind-key "M-;" 'comment-dwim-2))))

(defun personal/post-init-dash ()
  "Initialize dash config during bootstrap."
  (dash-enable-font-lock))

(defun personal/post-init-evil-mc ()
  (use-package evil-mc
    :init (global-evil-mc-mode 1)
    :config (progn
              (setq evil-mc-custom-known-commands
                    '((shrink-whitespace . ((:default . evil-mc-execute-default-call)))
                      (python-extras/smart-delete . ((:default . evil-mc-execute-default-call)))
                      (ess-smart-S-assign . ((:default . evil-mc-execute-default-call))))))))

(defun personal/init-evil-mc-extras ()
  (use-package evil-mc-extras
    :init (progn
            (require 'evil-mc-extras)
            (global-evil-mc-extras-mode 1))))

(defun personal/post-init-ess ()
  (add-hook 'Rnw-mode-hook 'spacemacs/load-yasnippet)
  (add-hook 'ess-mode-hook 'spacemacs/load-yasnippet)
  (with-eval-after-load 'ess-site
    (use-package ess-noweb
      :defer t
      ;; Helm fights with noweb, need this buffer to stop spurious errors
      :init (generate-new-buffer "*helm*")
      :config
      (progn
        (defun ess-noweb-post-command-function ()
          "The hook being run after each command in noweb mode."
          (condition-case err
              (ess-noweb-select-mode)
            (error)))))

    (use-package ess-site
      :defer t
      :config
      (progn

        (setq ess-roxy-str "#'")

        (evilified-state-evilify ess-help-mode ess-help-mode-map)

        (bind-key "M-;" 'comment-dwim-2 ess-mode-map)

        (bind-key "\t" nil ess-noweb-minor-mode-map)

        (add-hook 'ess-mode-hook 'turn-on-smartparens-strict-mode)
        (add-hook 'inferior-ess-mode-hook 'company-mode)

        (defun personal/disable-highlight-numbers ()
          (highlight-numbers-mode -1))

        (setq ess-mode-hook (append ess-mode-hook '(personal/disable-highlight-numbers)))
        (setq inferior-ess-mode-hook (append inferior-ess-mode-hook '(personal/disable-highlight-numbers)))

        (add-hook 'inferior-ess-mode-hook (defun personal/disable-comint-readonly ()
                                            (setq comint-prompt-read-only nil)))
        (add-hook 'inferior-ess-mode-hook (defun personal/force-smartparens ()
                                            (smartparens-mode 1)))

        (spacemacs/set-leader-keys-for-major-mode 'latex-mode
          "k" 'ess-swv-knit)
        (spacemacs/set-leader-keys-for-major-mode 'ess-mode
          "k" 'ess-swv-knit)

        (setq-default
         ess-offset-continued 0
         ess-pdf-viewer-pref "zathura"
         ess-R-font-lock-keywords '((ess-R-fl-keyword:modifiers . t)
                                    (ess-R-fl-keyword:fun-defs . t)
                                    (ess-R-fl-keyword:keywords . t)
                                    (ess-R-fl-keyword:assign-ops . t)
                                    (ess-R-fl-keyword:constants . t)
                                    (ess-fl-keyword:fun-calls . t)
                                    (ess-fl-keyword:numbers . t)
                                    (ess-fl-keyword:operators . t)
                                    (ess-fl-keyword:delimiters)
                                    (ess-fl-keyword:= . t)
                                    (ess-R-fl-keyword:F&T . t)
                                    )

         inferior-R-font-lock-keywords '((ess-S-fl-keyword:prompt . t)
                                         (ess-R-fl-keyword:messages . t)
                                         (ess-R-fl-keyword:modifiers . t)
                                         (ess-R-fl-keyword:fun-defs . t)
                                         (ess-R-fl-keyword:keywords . t)
                                         (ess-R-fl-keyword:assign-ops . t)
                                         (ess-R-fl-keyword:constants . t)
                                         (ess-fl-keyword:matrix-labels . t)
                                         (ess-fl-keyword:fun-calls)
                                         (ess-fl-keyword:numbers . t)
                                         (ess-fl-keyword:operators . t)
                                         (ess-fl-keyword:delimiters)
                                         (ess-fl-keyword:= . t)
                                         (ess-R-fl-keyword:F&T . t)))

        (evil-declare-key 'visual ess-mode-map
          (kbd "<tab>") 'indent-for-tab-command
          (kbd "C-d") 'evil-scroll-down)

        (evil-declare-key 'normal inferior-ess-mode-map
          (kbd "C-d") 'evil-scroll-down)
        (evil-declare-key 'normal ess-help-mode-map
          (kbd "Q") 'ess-help-quit
          (kbd "q") 'ess-help-quit)

        (add-hook 'R-mode-hook
                  (defun personal/R-whitespace-config ()
                    (set (make-local-variable 'whitespace-style)
                         (remove-if (lambda (x) (member x '(indentation::tab empty)))
                                    whitespace-style))))))
    (use-package ess-bugs-d)))


(defun personal/init-whitespace-cleanup-mode ()
  (use-package whitespace-cleanup-mode
    :init (add-hook 'prog-mode
                    (defun personal/turn-on-whitespace-cleanup ()
                      (global-whitespace-cleanup-mode 1)))
    :config
    (progn
      (setq-default whitespace-style (remove 'indentation whitespace-style))

      (global-whitespace-cleanup-mode 1)
      (add-hook 'makefile-mode-hook (lambda () (whitespace-cleanup-mode -1))))))

(defun personal/init-parenface ()
  (use-package paren-face))

(defun personal/post-init-company ()
  (use-package company
    :defer t
    :config
    (progn
      (bind-keys :map company-active-map
                 ("C-n" . company-select-next)
                 ("C-p" . company-select-previous)
                 ("C-h" . help-command)
                 ("C-w" . personal/kill-region-or-backward-word)
                 ("C-l" . company-show-location)
                 ("M-1" . nil)
                 ("M-2" . nil)))))

(defun personal/init-dired-rainbow ()
  (use-package dired-rainbow
    :config
    (progn
      (defconst dired/media-files-extensions
        '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
        "Media files.")
      (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
      (dired-rainbow-define media "#ce5c00" dired/media-files-extensions)
      (dired-rainbow-define-chmod executable-unix "Green" "-.*x.*")
      (dired-rainbow-define log (:inherit default
                                          :italic t) ".*\\.log"))))

(defun personal/post-init-helm-swoop ()
  (use-package helm-swoop
    :commands (helm-swoop helm-multi-swoop)
    :init
    (setq helm-swoop-pre-input-function (lambda () ""))
    :config
    (bind-keys :map helm-swoop-map
               ("C-w" . backward-kill-word))))

(defun personal/init-emms ()
  (use-package emms
    :commands emms-smart-browse
    :config
    (progn
      (emms-standard)
      (setq emms-player-list '(emms-player-mpd))
      (emms-devel)
      (defadvice emms-browser-mode (after use-emacs-mode-please activate)
        (evil-evilified-state))
      (evilified-state-evilify-map emms-browser-mode-map
        :mode emms-browser-mode)
      (evilified-state-evilify-map emms-playlist-mode-map
        :mode emms-playlist-mode)
      )))

(defun personal/init-emr ()
  (use-package emr
    :commands (emr-initialize emr-show-refactor-menu)
    :init (progn
            (add-hook 'prog-mode-hook 'emr-initialize)
            (evil-leader/set-key "ar" 'emr-show-refactor-menu))))

(defun personal/post-init-prodigy ()
  (use-package prodigy
    :commands prodigy
    :config
    (progn
      (add-to-list 'evil-emacs-state-modes 'prodigy-mode)
      (prodigy-define-service
        :name "Leiningen"
        :command "lein"
        :args '("repl" ":headless")
        :cwd user-emacs-directory
        :tags '(clojure)
        :stop-signal 'int
        :kill-process-buffer-on-stop t))))

(defun personal/post-init-magit ()
  (use-package magit
    :defer t
    :config
    (progn
      (defadvice magit-show-level-4 (after user-magit/center-after-move activate)
        (recenter))
      (defadvice magit-goto-next-sibling-section (after user-magit/center-after-move activate)
        (recenter))
      (defadvice magit-goto-previous-sibling-section (after user-magit/center-after-move activate)
        (recenter)))))

(defun personal/post-init-company-quickhelp ()
  (use-package company-quickhelp
    :defer t
    :config
    (setq-default company-quickhelp-max-lines 20)))

;; Better yasnippet
;; Plans:
;; f  - function
;; m  - method
;; t  - test
;; tc - testclass
;; c  - class/type
;; l  - forloop
;; i  - if
;; e  - exception
(defun personal/post-init-yasnippet ()
  (use-package yasnippet
    :defer t
    :init
    (progn

      (defvar personal/yas-initialized nil)
      (defun personal/add-my-snippets ()
        (when (not personal/yas-initialized)
          (setq personal/yas-initialized t)
          (add-to-list 'yas-snippet-dirs (concat dotspacemacs-directory "snippets"))
          (yas-reload-all)))
      (defadvice spacemacs/load-yasnippet (after personal/use-my-snippets activate)
        (personal/add-my-snippets)))))

(defun personal/init-shrink-whitespace ()
  (use-package shrink-whitespace
    :defer t
    :bind ("M-\\" . shrink-whitespace)))

(defun personal/post-init-go-mode ()
  (use-package go-mode
    :defer t
    :init
    (add-hook 'go-mode-hook (defun personal/go-mode-tab-width ()
                              (setq tab-width 8)))))

(defun personal/init-browse-url ()
  (use-package browse-url
    :defer t
    :init
    (setq gnus-button-url 'browse-url-generic
          browse-url-generic-program (getenv "BROWSER")
          browse-url-browser-function gnus-button-url)))

(defun personal/init-simple ()
  (use-package simple
    :config (setq-default shell-file-name (executable-find "bash"))))

(defun personal/post-init-recentf ()
  (use-package recentf
    :defer t
    :init
    (progn
      (defvar personal/recentf-lazy-loaded nil)

      (defun personal/lazy-load-recentf ()
        (unless personal/recentf-lazy-loaded
          (recentf-mode 1)
          (recentf-track-opened-file)
          (recentf-load-list)
          (setq personal/recentf-lazy-loaded t)))

      (defadvice helm-projectile-find-file (before recentf/load-list-for-helm activate)
        (personal/lazy-load-recentf))

      (defadvice helm-mini (before recentf/load-list-for-helm activate)
        (personal/lazy-load-recentf))

      (setq recentf-max-saved-items 1000
            recentf-auto-cleanup 'mode))))

(defun personal/init-hippie-expand ()
  (use-package hippie-exp
    :bind (("M-/" . hippie-expand)
           ("M-?" . hippie-expand-lines))
    :init
    (progn
      (defun hippie-expand-lines ()
        (interactive)
        (let ((hippie-expand-try-functions-list '(try-expand-list
                                                  try-expand-list-all-buffers
                                                  try-expand-line
                                                  try-expand-line-all-buffers)))
          (hippie-expand nil))))

    :config
    (progn
      (setq-default hippie-expand-dabbrev-skip-space t)
      (defadvice he-substitute-string (after completion/he-paredit-fix activate)
        "remove extra paren when expanding line in paredit"
        (if (and paredit-mode (equal (substring str -1) ")"))
            (progn (backward-delete-char 1) (forward-char)))))))

(defun personal/init-wdired ()
  (use-package wdired
    :defer t))

(defun personal/post-init-dired ()
  (use-package dired
    :defer t
    :config
    (progn
      (require 'wdired)
      (setq-default dired-hide-details-hide-symlink-targets nil
                    dired-guess-shell-alist-user '(("\\.pdf\\'" "zathura "))
                    dired-dwim-target t)

      (defun dired/use-dired-x ()
        (load "dired-x"))

      (add-hook 'dired-load-hook 'dired/use-dired-x)
      (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

      (defun dired-back-to-start-of-files ()
        (interactive)
        (backward-char (- (current-column) 2)))

      (defun dired-back-to-top ()
        (interactive)
        (beginning-of-buffer)
        (dired-next-line 3))

      (defun dired-jump-to-bottom ()
        (interactive)
        (end-of-buffer)
        (dired-next-line -1))

      (bind-keys :map dired-mode-map
                 ("C-a" . dired-back-to-start-of-files)
                 ("C-p" . helm-projectile-find-file)
                 ("k" . dired-do-delete)
                 ("C-x C-k" . dired-do-delete))

      (bind-keys :map dired-mode-map
                 ([remap beginning-of-buffer] . dired-back-to-top)
                 ([remap smart-up] . dired-back-to-top)
                 ([remap end-of-buffer] . dired-jump-to-bottom)
                 ([remap smart-down] . dired-jump-to-bottom))

      (bind-keys :map wdired-mode-map
                 ("C-a" . dired-back-to-start-of-files)
                 ([remap beginning-of-buffer] . dired-back-to-top)
                 ([remap end-of-buffer] . dired-jump-to-bottom))

      (evil-declare-key 'normal dired-mode-map
        (kbd "n") 'evil-search-next))))

(defun personal/post-init-doc-view ()
  (use-package doc-view
    :defer t
    :config
    (setq-default doc-view-continuous t)))

(defun personal/post-init-js2-mode ()
  (use-package js2-mode
    :defer t
    :bind (:map js2-mode-map
                ("M-k" . personal/move-cursor-previous-pane)
                ("M-j" . personal/move-cursor-next-pane))))

(defun personal/init-helm-pass ()
  (use-package helm-pass
    :defer t
    :commands helm-pass
    :init
    (evil-leader/set-key "aw" 'helm-pass)))

(defun personal/init-writeroom-mode ()
  (use-package writeroom-mode
    :defer t
    :commands writeroom-mode
    :init
    (progn
      (defvar writeroom-mode nil)
      (defun personal/distraction-free-enable ()
        (interactive)
        (zoom-in/out 6)
        (git-gutter+-mode -1)
        (writeroom-mode 1))

      (defun personal/distraction-free-disable ()
        (interactive)
        (zoom-frm-unzoom)
        (git-gutter+-mode 1)
        (writeroom-mode -1))

      (defun personal/distraction-free-toggle ()
        (interactive)
        (if writeroom-mode
            (personal/distraction-free-disable)
          (personal/distraction-free-enable)))

      (evil-leader/set-key "wn" 'personal/distraction-free-toggle))))

;; autoload zoom-frm
(defun personal/post-init-zoom-frm ()
  (use-package zoom-frm
    :commands (zoom-in/out)))

(defun personal/pre-init-slack ()
  (load-secrets))

(defun personal/post-init-slack ()
  (use-package slack
    :defer t
    :config
    (progn
      (setq alert-default-style 'libnotify)

      (setq slack-buffer-function #'switch-to-buffer)

      (add-hook 'slack-mode-hook (defun personal/highlight-nick ()
                                   (set (make-local-variable 'lui-highlight-keywords) '("jcpetkovich" "jcp"))))

      (spacemacs/set-leader-keys
        "aCu" 'slack-select-unread-rooms)

      (defun slack-file-upload-wrap ()
        (interactive)
        (let ((completing-read-function 'completing-read-default))
          (slack-file-upload)))
      (bind-keys ([remap slack-file-upload] . slack-file-upload-wrap))

      (spacemacs/set-leader-keys-for-major-mode 'slack-mode
        "f" 'slack-file-upload
        "g" 'slack-group-select)

      (slack-register-team
       :name "embeddedsoftwaregroup"
       :default t
       :client-id esg-slackid
       :client-secret esg-slackpass
       :token esg-slacktoken
       :subscribed-channels '(general slackbot sfischme gmtchamg
                                      andersonoliveira jmorgan lukas
                                      skauffma waleedqk r docker-compute-1 datamill-v2))

      (slack-register-team
       :name "acertateam"
       :default t
       :client-id slackid
       :client-secret slackpass
       :token slacktoken
       :subscribed-channels '(general bitbucket slackbot analytics praj himesh
                                      paddy25 allen-huang gcutulenco renesas-demo beernpong)))))

(defun personal/post-init-ranger ()
  (use-package ranger
    :init
    (progn
      ;; undo/redo doesn't make sense in dired/ranger anyways.
      (setq ranger-override-dired t)
      (ranger-override-dired-mode 1)
      (setq ranger-key (kbd "C-r"))

      ;; patch ranger-still-dired for unnamed windows as it is generally more confusing than not
      (defun ranger-still-dired ()
        "Enable or disable ranger based on current mode"
        (ranger--message "ranger-still-dired : mode %s : window : %s"
                         major-mode
                         (selected-window))
        ;; TODO Try to manage new windows / frames created without killing ranger
        (let* ((ranger-window-props
                (r--aget ranger-w-alist
                         (selected-window)))
               (prev-buffer (car ranger-window-props))
               (minimal (r--fget ranger-minimal))
               (ranger-buffer (cdr ranger-window-props))
               (current (current-buffer))
               (buffer-fn (buffer-file-name (current-buffer))))
          (cond
           ((and buffer-fn (not (eq  current ranger-buffer)))
            (message "File opened, exiting ranger")
            (ranger-disable)
            (find-file buffer-fn)
            (setq-local cursor-type t)
            (setq header-line-format ranger-pre-header-format))
           ((eq major-mode 'dired-mode)
            (if minimal
                (deer)
              (ranger)))
           (t
            ;; nothing else to do
            )))))
    :config
    (progn
      (bind-keys :map ranger-mode-map
                 ("C-p" . helm-projectile-find-file)
                 ("C-h" . help-command))
      (setq ranger-preview-file t))))

(defun personal/init-polymode ()
  (use-package polymode
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

      ;; R modes
      ;; (add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
      ;; (add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
      (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode)))))


(defun personal/post-init-web-mode ()
  (use-package web-mode
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.jinja\\'" . web-mode)))))
