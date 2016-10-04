;; -*- mode: emacs-lisp -*-
(defconst user/spacemacs-repo "https://github.com/syl20bnr/spacemacs")
(defconst dotspacemacs-directory (expand-file-name "~/.spacemacs.d/"))

;; Bootstrap Spacemacs
;; -------------------
(defun user/bootstrap-emacs-config ()
  (shell-command (concat "git clone --recursive " user/spacemacs-repo " " user-emacs-directory))
  (shell-command (concat "ln -sf " dotspacemacs-directory ".mc-lists.el" " ~/.emacs.d/.mc-lists.el"))
  (message "Spacemacs bootstrapped, restart emacs."))

(if (not (file-exists-p (concat user-emacs-directory "spacemacs")))
    (if (file-exists-p user-emacs-directory)
        (message "Warning, user-emacs-directory exists and is not spacemacs, please remove it")
      (user/bootstrap-emacs-config)))

;; Utils
;; -----

(defun user/update-layer (repo-path)
  (shell-command (concat "cd " repo-path "; git pull")))

(defun user/bootstrap-layer (repo-string repo-path)
  (shell-command (concat "git clone --recursive " repo-string " " repo-path)))

;; Configuration Layers
;; --------------------

(defvar user/external-layers
  '(
    ;;    ("git@github.com:jcpetkovich/spacemacs.elisp-extras" . elisp-extras)
    )
  )

(defvar user/internal-layers
  '(
    blog
    ebuild
    elisp-extras
    (rust-extras :variables
                 rust/lang-src-path "~/labs/rust")
    python-extras
    ein-extras
    c-extras
    mu4e
    email-config
    eshell
    (helm-everything :variables
                     helm-everything/really-everything t)
    irc-config
    (rust-extras :variables
                 rust-extras/lang-src-path "~/labs/rust/")
    journal
    multiple-cursors
    personal
    theme
    ))

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
   dotspacemacs-configuration-layers '(
                                       csv
                                       (git :variables
                                            git-magit-status-fullscreen t)
                                       (ess :variables
                                            ess-enable-smart-equals nil)
                                       (haskell :variables
                                                haskell-enable-hindent-support t)
                                       erc
                                       (rcirc :variables
                                              rcirc-enable-znc-support t)
                                       (shell :variables
                                              shell-default-shell 'eshell)
                                       (c-c++ :variables
                                              c-c++-enable-clang-support t)
                                       ;; buggy for now
                                       ;; semantic
                                       ;; django
                                       auto-completion
                                       clojure
                                       colors
                                       common-lisp
                                       cscope
                                       docker
                                       elixir
                                       emacs-lisp
                                       fasd
                                       finance
                                       go
                                       ranger
                                       slack
                                       gtags
                                       html
                                       ipython-notebook
                                       javascript
                                       latex
                                       markdown
                                       octave
                                       org
                                       pdf-tools
                                       prodigy
                                       python
                                       restclient
                                       ruby
                                       rust
                                       scheme
                                       shell-scripts
                                       spacemacs-helm
                                       spacemacs-layers
                                       spell-checking
                                       sql
                                       syntax-checking
                                       typescript
                                       version-control
                                       yaml
                                       ycmd
                                       )
   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '(
                                    evil-escape
                                    )
   dotspacemacs-delete-orphan-packages t)

  ;; Initialize and/or update external layers
  (mapc (lambda (layer)
          (let* ((repo-string (car layer))
                 (spacemacs-layer (cdr layer))
                 (spacemacs-layer-string (symbol-name (if (equalp (type-of spacemacs-layer) 'symbol)
                                                          spacemacs-layer
                                                        (car spacemacs-layer))))
                 (repo-path (concat
                             user-emacs-directory "private/"
                             spacemacs-layer-string)))
            (if (not (file-exists-p repo-path))
                (user/bootstrap-layer repo-string repo-path))
            (push 'spacemacs-layer dotspacemacs-configuration-layers)
            (user/update-layer repo-path)))
        user/external-layers)

  ;; Initialize internal layers
  (setq dotspacemacs-configuration-layers
        (append dotspacemacs-configuration-layers user/internal-layers)))

;; Initialization Hooks
;; --------------------

(defun dotspacemacs/init ()
  "User initialization for Spacemacs. This function is called at the very
 startup."
  ;; Get rid of these no matter what, and do it early
  (setq load-prefer-newer t)

  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 10
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark spacemacs-light solarized-dark solarized-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Sauce Code Powerline 6"
                               :weight normal
                               :width normal
                               :powerline-offset 2)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key "SPC"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server t
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  (vi-tilde-fringe-mode 1))

;; Custom variables
;; ----------------

;; Do not write anything in this section. This is where Emacs will
;; auto-generate custom variable definitions.


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(custom-safe-themes
   (quote
    ("2f48d3e78a730496187bad754d1ba308f4124463cfd130ad315395c9de116e00" default)))
 '(evil-want-C-i-jump nil)
 '(paradox-automatically-star nil)
 '(ring-bell-function (quote ignore) t)
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-include-path "/usr/include/glib-2.0/" "/usr/lib64/glib-2.0/include/")
     (flycheck-clang-language-standard . "c99")
     (flycheck-gcc-include-path "/usr/include/glib-2.0/" "/usr/lib64/glib-2.0/include/")
     (flycheck-gcc-language-standard . "c99"))))
 '(shell-file-name "/bin/bash"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((((class color) (min-colors 89)) (:background "#6c6c6c" :foreground "#afd7ff"))))
 '(company-tooltip-common-selection ((((class color) (min-colors 89)) (:background "#005f87" :foreground "#afd7ff" :bold t)))))
