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
    comment-dwim-2
    dash
    ess
    evil
    evil-leader
    helm
    multiple-cursors
    paredit
    whitespace-cleanup-mode
    parenface
    company
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
   display-time-24hr-format  nil)

  (setq-default frame-title-format
                (list
                 '(:eval (if buffer-file-name (buffer-file-name) (buffer-name))))))

(defun personal/editing-configs ()
  (setq-default recentf-max-saved-items 1000
                ido-use-virtual-buffers t))

(defun personal/helm-configs ()
  (setq-default helm-always-two-windows nil)

  (bind-keys
   ("C-x C-b" . helm-C-x-b)
   ("C-x b" . helm-C-x-b))

  (evil-leader/set-key
    "ss" 'helm-everything/swoop-no-arg
    "bs" 'helm-C-x-b
    "o"  'helm-cmd-t
    "/"  'helm-cmd-t-grep))

(defadvice dotspacemacs/config (before personal-vars activate)
  "Overriding spacemacs and other layer defaults."
  (personal/appearance-configs)
  (personal/editing-configs)
  (personal/helm-configs)

  (window-numbering-mode -1)
  ;; This is a good time to load the recentf list
  (recentf-load-list))

(defun personal/init-multiple-cursors ()
  (use-package multiple-cursors
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
    :config
    (progn
      (require 'helm-tags)
      (require 'helm-regexp)
      (require 'helm-grep)
      (require 'helm-files)
      (require 'helm-man)

      (bind-keys :map helm-map
                 ("C-i" . helm-execute-persistent-action)
                 ("C-M-i" . helm-select-action))

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
                            ("C-w" . personal/kill-region-or-backward-word)
                            ("M-w" . helm-yank-text-at-point)))))

      (bind-key "C-w" 'helm-find-files-up-one-level helm-find-files-map)

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
          (error))))))

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
    :config
    (progn
      (bind-keys :map paredit-mode-map
                 ("M-?" . hippie-expand-lines))
      (defadvice paredit-close-round (after paredit-close-and-indent activate)
        (personal/cleanup-buffer))

      (eval-after-load 'comment-dwim-2
        '(progn
           (--each '(insert visual normal)
             (evil-declare-key it paredit-mode-map
               (kbd "M-;") 'comment-dwim-2))))
      (eval-after-load 'user-utils
        '(progn
           (--each '(insert visual normal)
             (evil-declare-key it paredit-mode-map
               (kbd "C-w") 'personal/kill-region-or-backward-word)))))))

(defun personal/init-comment-dwim-2 ()
  (use-package comment-dwim-2
    :init
    (progn
      (bind-key "M-;" 'comment-dwim-2))))

(defun personal/init-dash ()
  (use-package dash
    :config
    (dash-enable-font-lock)))

(defun personal/init-ess ()
  (defadvice load-ess-on-demand (after personal-ess-settings activate)
    (use-package ess-noweb
      :defer t
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

        (evil-leader/set-key-for-mode 'latex-mode "mk" 'ess-swv-knit)
        (evil-leader/set-key-for-mode 'ess-mode "mk" 'ess-swv-knit
          "mcn" 'ess-noweb-next-chunk
          "mcN" 'ess-noweb-previous-chunk
          "mcc" 'ess-eval-chunk
          "mcC" 'ess-eval-chunk-and-go
          "mcd" 'ess-eval-chunk-and-step)

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
         ess-default-style 'OWN
         ess-own-style-list '((ess-indent-level . 4)
                              (ess-continued-statement-offset . 4)
                              (ess-brace-offset . 0)
                              (ess-expression-offset . 4)
                              (ess-else-offset . 0)
                              (ess-brace-imaginary-offset . 0)
                              (ess-continued-brace-offset . 0)
                              (ess-arg-function-offset . 2)
                              (ess-close-brace-offset . 0))

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
          (kbd "q") 'ess-help-quit)))))

(use-package whitespace-cleanup-mode
  :config
  (progn
    (setq-default whitespace-style (remove 'indentation whitespace-style))
    
    (global-whitespace-cleanup-mode)
    (add-hook 'makefile-mode-hook (lambda () (whitespace-cleanup-mode -1)))

    (eval-after-load 'ess-site
      (add-hook 'R-mode-hook
                (defun personal/R-whitespace-config ()
                  (set (make-local-variable 'whitespace-style)
                       (remove 'empty whitespace-style)))))))

(defun personal/init-parenface ()
  (use-package parenface))


(defun personal/init-company ()

  (use-package company
    :defer t
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
    :init
    (setq helm-swoop-pre-input-function (lambda () ""))))

;; (eval-after-load 'user-utils
;;   '(progn
;;      (--each '(insert visual normal)
;;        (evil-declare-key it paredit-mode-map
;;          (kbd "C-w") 'personal/kill-region-or-backward-word))))
