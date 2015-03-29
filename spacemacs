;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; Configuration Layers
;; --------------------

(setq-default
 dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
 dotspacemacs-configuration-layers '(
                                     (git :variables
                                          git-magit-status-fullscreen t)
                                     (ess :variables
                                          ess-enable-smart-equals nil)
                                     (haskell :variables
                                              haskell-enable-hindent-support t)
                                     (rcirc :variables
                                            rcirc-enable-znc-support t)
                                     ;; go
                                     auctex
                                     c-c++
                                     clojure
                                     colors
                                     company-mode
                                     erlang-elixir
                                     fasd
                                     html
                                     javascript
                                     markdown
                                     pcre2el
                                     python
                                     restclient
                                     ruby
                                     )
 dotspacemacs-excluded-packages '())

(setq-default
 dotspacemacs-startup-banner 'official
 dotspacemacs-themes '(moe-dark moe-light)
 dotspacemacs-leader-key "SPC"
 dotspacemacs-major-mode-leader-key ","
 dotspacemacs-command-key ":"
 dotspacemacs-guide-key-delay 0.4
 dotspacemacs-fullscreen-at-startup nil
 dotspacemacs-fullscreen-use-non-native nil
 dotspacemacs-helm-micro-state t
 dotspacemacs-maximized-at-startup nil
 dotspacemacs-active-transparency 90
 dotspacemacs-inactive-transparency 90
 dotspacemacs-mode-line-unicode-symbols nil
 dotspacemacs-smooth-scrolling t
 dotspacemacs-smartparens-strict-mode t
 dotspacemacs-persistent-server t
 dotspacemacs-default-package-repository nil
 dotspacemacs-enable-paste-micro-state t
 dotspacemacs-default-font '("Sauce Code Powerline" :size 14 :weight normal :width normal :powerline-offset 2))

;; Initialization Hooks
;; --------------------

(defconst user/spacemacs-repo "https://github.com/syl20bnr/spacemacs")
(defconst user/spacemacs-d-path "~/.spacemacs.d/")

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
    (rust :variables
          rust/lang-src-path "~/labs/rust")
    python-extras
    c-extras
    email
    eshell
    (helm-everything :variables
                     helm-everything/really-everything t)
    irc-config
    journal
    multiple-cursors
    personal
    shrink-whitespace
    theme
    ))

(defun user/bootstrap-emacs-config ()
  (shell-command (concat "git clone --recursive " user/spacemacs-repo " " user-emacs-directory))
  (shell-command (concat "ln -sf " user/spacemacs-d-path "spacemacs" " ~/.spacemacs"))
  (shell-command (concat "ln -sf " user/spacemacs-d-path ".mc-lists.el" " ~/.emacs.d/.mc-lists.el"))
  (message "Spacemacs bootstrapped, restart emacs."))

(defun user/update-layer (repo-path)
  (shell-command (concat "cd " repo-path "; git pull")))

(defun user/bootstrap-layer (repo-string repo-path)
  (shell-command (concat "git clone --recursive " repo-string " " repo-path)))

(defun dotspacemacs/init ()
  "User initialization for Spacemacs. This function is called at the very
 startup."
  ;; Get rid of these no matter what, and do it early
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq load-prefer-newer t)

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

(defun dotspacemacs/config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  (vi-tilde-fringe-mode 1))

;; Bootstrap Spacemacs
;; -------------------
(if (not (file-exists-p (concat user-emacs-directory "spacemacs")))
    (if (file-exists-p user-emacs-directory)
        (message "Warning, user-emacs-directory exists and is not spacemacs, please remove it")
      (user/bootstrap-emacs-config)))

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
 '(ring-bell-function (quote ignore) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
