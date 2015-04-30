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

(defvar personal-packages
  '(
    auctex
    comment-dwim-2
    company
    dash
    dired-rainbow
    emms
    emr
    ess
    company-ess
    evil
    evil-leader
    helm
    helm-swoop
    magit
    multiple-cursors
    paradox
    paredit
    parenface
    prodigy
    whitespace-cleanup-mode
    company-quickhelp
    yasnippet
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar personal-excluded-packages '()
  "List of packages to exclude.")

(defun personal/appearance-configs ()
  (setq-default
   mouse-wheel-scroll-amount '(1)
   scroll-conservatively     100000
   show-paren-style          'expression
   display-time-day-and-date nil
   display-time-24hr-format  nil

   frame-title-format
   (list
    '(:eval (if buffer-file-name (buffer-file-name) (buffer-name)))))

  ;; (window-numbering-mode -1)
  (golden-ratio-mode 1))

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
  (load (concat user/spacemacs-d-path "secrets.el.gpg")))

(defun personal/init-paradox ()
  (use-package paradox
    :defer t
    :config
    (load-secrets)))

(defun personal/helm-configs ()

  (setq-default helm-split-window-default-side 'other
                helm-always-two-windows nil)

  ;; I prefer my own grep wrapper.
  (defun helm-do-grep-wrapper (arg)
    (interactive "P")
    (let ((current-prefix-arg (not arg)))
      (helm-do-grep)))

  (bind-keys
   ([remap rgrep] . helm-do-grep-wrapper)
   ("M-o" . helm-cmd-t))

  (use-package helm
    :defer t
    :config
    (bind-keys :map helm-map
               ("<escape>" . spacemacs/helm-navigation-micro-state)
               ("C-i" . helm-execute-persistent-action)
               ("<tab>" . helm-execute-persistent-action)
               ("C-M-i" . helm-select-action)))

  (evil-leader/set-key
    "qq" 'spacemacs/save-buffers-kill-emacs
    "o"  'helm-C-x-b
    "O"  'helm-projectile-find-file
    "/"  'helm-cmd-t-grep))

(defun personal/keybinding-configs ()

  (add-to-list 'guide-key/guide-key-sequence "C-w")

  (defun annoying ()
    (interactive)
    (message "Try something else"))

  (bind-keys
   ("C-x C-f" . annoying)
   ("C-x C-b" . annoying)
   ("C-x b" . annoying)
   ("C-x C-s" . annoying)
   ("C-x k" . annoying)))

(defadvice dotspacemacs/config (before personal-vars activate)
  "Overriding spacemacs and other layer defaults."
  (personal/appearance-configs)
  (personal/editing-configs)
  (personal/spacemacs-configs)
  (personal/helm-configs)
  (personal/org-mode-configs)
  (personal/keybinding-configs))

(defun personal/init-auctex ()

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

      (evil-leader/set-key-for-mode 'latex-mode
        "md" 'personal/tex-delete-env-pair)


      (add-hook 'LaTeX-mode-hook 'reftex-mode)
      (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
      (add-hook 'LaTeX-mode-hook 'orgtbl-mode)
      (add-hook 'LaTeX-mode-hook 'turn-on-smartparens-mode)

      (push '("zathura" "zathura -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf")
            TeX-view-program-list)
      (push '(output-pdf "zathura")
            TeX-view-program-selection)

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

(defun personal/init-multiple-cursors ()
  (use-package multiple-cursors
    :defer t
    :init
    (bind-keys
     ("M-m" . multiple-cursors/expand-or-mark-next-symbol)
     ("M-M" . multiple-cursors/expand-or-mark-next-word)
     ("M-'" . mc/mark-all-dwim)
     ("C-S-n" . mc/mmlte--down)
     ("C-S-p" . mc/mmlte--up)
     ("C-S-f" . mc/mmlte--right)
     ("C-S-b" . mc/mmlte--left))))

(defun personal/init-helm ()
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

(defun personal/init-evil ()
  "Initialize my package"
  (use-package evil
    :init
    (progn
      (setq-default evil-symbol-word-search t
                    evil-cross-lines t
                    evil-esc-delay 0))))

(defun personal/init-paredit ()
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
          (kbd "C-w") 'personal/kill-region-or-backward-word)))))

(defun personal/init-comment-dwim-2 ()
  (use-package comment-dwim-2
    :commands comment-dwim-2
    :init
    (progn
      (bind-key "M-;" 'comment-dwim-2))))

(defun personal/init-dash ()
  (use-package dash
    :defer t
    :config
    (dash-enable-font-lock)))

(spacemacs|defvar-company-backends inferior-ess-mode)
(when (configuration-layer/layer-usedp 'auto-completion)
  (defun personal/post-init-company ()
    (spacemacs|add-company-hook inferior-ess-mode))

  (defun personal/init-company-ess ()
    (use-package company-ess
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :init
      (push '(company-ess-backend :with company-yasnippet)
            company-backends-inferior-ess-mode))))

(defun personal/init-ess ()
  (defadvice load-ess-on-demand (after personal-ess-settings activate)
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
        (bind-key "M-;" 'comment-dwim-2 ess-mode-map)

        (bind-key "\t" nil ess-noweb-minor-mode-map)

        (add-hook 'ess-mode-hook 'turn-on-smartparens-strict-mode)
        (add-hook 'inferior-ess-mode-hook (defun personal/force-smartparens ()
                                            (smartparens-strict-mode 1)))

        (evil-leader/set-key-for-mode 'latex-mode "mk" 'ess-swv-knit)
        (evil-leader/set-key-for-mode 'ess-mode
          "mk" 'ess-swv-knit)

        (setq-default
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
                                    (ess-R-fl-keyword:F&T . t))

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
                         (remove 'empty whitespace-style))))))
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
  (use-package parenface))


(defun personal/init-company ()
  (use-package company
    :defer t
    :config
    (bind-keys :map company-active-map
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous)
               ("C-h" . help-command)
               ("C-w" . personal/kill-region-or-backward-word)
               ("C-l" . company-show-location)
               ("M-1" . nil)
               ("M-2" . nil))))

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

(defun personal/init-helm-swoop ()
  (use-package helm-swoop
    :commands (helm-swoop helm-multi-swoop)
    :init
    (setq helm-swoop-pre-input-function (lambda () ""))))

(defun personal/init-emms ()
  (use-package emms
    :commands emms-smart-browse
    :config
    (progn
      (emms-standard)
      (setq emms-player-list '(emms-player-mpd))
      (emms-devel)
      (defadvice emms-browser-mode (after use-emacs-mode-please activate)
        (evil-emacs-state))
      (--each '(emms-browser-mode emms-playlist-mode)
        (add-to-list 'evil-emacs-state-modes it)))))

(defun personal/init-emr ()
  (use-package emr
    :commands (emr-initialize emr-show-refactor-menu)
    :init (progn
            (add-hook 'prog-mode-hook 'emr-initialize)
            (evil-leader/set-key "ar" 'emr-show-refactor-menu))))

(defun personal/init-prodigy ()
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

(defun personal/init-magit ()
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

(defun personal/init-company-quickhelp ()
  (use-package company-quickhelp
    :defer t
    :config
    (setq-default company-quickhelp-max-lines 20)))

(defun personal/init-yasnippet ()
  (use-package yasnippet
    :defer t
    :init
    (progn
      (defvar personal/yas-initialized nil)
      (defun personal/add-my-snippets ()
        (when (not personal/yas-initialized)
          (setq personal/yas-initialized t)
          (add-to-list 'yas-snippet-dirs (concat user/spacemacs-d-path "snippets"))
          (yas-reload-all)))
      (defadvice spacemacs/load-yasnippet (after personal/use-my-snippets activate)
        (personal/add-my-snippets)))))
