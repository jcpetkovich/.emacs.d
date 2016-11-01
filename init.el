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
   dotspacemacs-themes '(spacemacs-light spacemacs-dark solarized-light solarized-dark)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("PragmataPro 6"
                               ;; :weight normal
                               ;; :width normal
                               ;; :powerline-offset 2
                               )
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
  (vi-tilde-fringe-mode 1)
  (slack-start))

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
 '(ansi-color-names-vector
   ["#d2ceda" "#f2241f" "#67b11d" "#b1951d" "#3a81c3" "#a31db1" "#21b8c7" "#655370"])
 '(asana-my-tasks-project-id 181934175878123 t)
 '(asana-selected-workspace (quote ((id . 181854447419726) (name . "acerta.ca"))) t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("2f48d3e78a730496187bad754d1ba308f4124463cfd130ad315395c9de116e00" default)))
 '(erc-modules
   (quote
    (completion log services image hl-nicks youtube services netsplit fill button match track readonly networks ring autojoin noncommands irccontrols move-to-prompt stamp menu list)))
 '(evil-want-C-i-jump nil)
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(image-dired-dir "/home/jcp/.emacs.d/.cache/image-dir")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (polymode slime-company pug-mode ob-elixir minitest insert-shebang hide-comnt helm-purpose window-purpose imenu-list ranger zenburn-theme dockerfile-mode docker docker-tramp visual-fill-column typescript-mode powerline tablist pcre2el git mustache org ht markdown-mode macrostep skewer-mode simple-httpd json-snatcher json-reformat js2-mode jedi-core python-environment epc concurrent htmlize parent-mode password-store xcscope haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter flyspell-correct pos-tip flycheck flx grizzl magit magit-popup git-commit with-editor smartparens anzu evil goto-chg undo-tree ctable ess julia-mode iedit projectile redshank list-utils websocket dired-hacks-utils diminish ycmd request-deferred request deferred web-completion-data dash-functional tern go-mode ghc haskell-mode hydra inflections edn multiple-cursors paredit peg clang-format eval-sexp-fu highlight cider seq spinner queue clojure-mode rust-mode inf-ruby bind-map bind-key yasnippet packed auctex anaconda-mode pythonic f s alert log4e gntp company dash elixir-mode pkg-info epl helm avy helm-core async auto-complete popup package-build erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks znc slack emojify circe oauth2 asana graphviz-dot-mode yapfify yaml-mode xterm-color ws-butler writeroom-mode window-numbering whitespace-cleanup-mode which-key web-mode web-beautify volatile-highlights virtualenvwrapper vi-tilde-fringe uuidgen use-package toml-mode toc-org tide tagedit sql-indent spacemacs-theme spaceline solarized-theme smeargle smart-tabs-mode slime slim-mode shrink-whitespace shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restclient restart-emacs rcirc-notify rcirc-color rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters racer quelpa pyvenv pytest pyenv-mode py-isort prodigy popwin pip-requirements persp-mode pdf-tools paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-page org-download org-caldav org-bullets open-junk-file ob-http neotree multi-term mu4e-maildirs-extension mu4e-alert move-text moe-theme mmm-mode markdown-toc magit-gitflow lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode ledger-mode json-mode js2-refactor js-doc jedi jade-mode ipretty intero info+ indent-guide ido-vertical-mode hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-pass helm-mode-manager helm-make helm-hoogle helm-gtags helm-gitignore helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-cmd-t helm-c-yasnippet helm-ag haskell-snippets google-translate google-c-style golden-ratio go-eldoc gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md ggtags geiser flyspell-correct-helm flycheck-ycmd flycheck-rust flycheck-pos-tip flycheck-mix flycheck-ledger flycheck-haskell flx-ido fish-mode fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-ediff evil-args evil-anzu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z eshell-prompt-extras esh-help emr emms emmet-mode elisp-slime-nav ein dumb-jump disaster dired-rainbow diff-hl define-word cython-mode csv-mode company-ycmd company-web company-tern company-statistics company-shell company-quickhelp company-go company-ghci company-ghc company-cabal company-c-headers company-auctex company-anaconda common-lisp-snippets comment-dwim-2 column-enforce-mode color-identifiers-mode coffee-mode cmm-mode cmake-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby cargo bundler autopair auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk alchemist aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-automatically-star nil)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-include-path "/usr/include/glib-2.0/" "/usr/lib64/glib-2.0/include/")
     (flycheck-clang-language-standard . "c99")
     (flycheck-gcc-include-path "/usr/include/glib-2.0/" "/usr/lib64/glib-2.0/include/")
     (flycheck-gcc-language-standard . "c99"))))
 '(shell-file-name "/bin/bash")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
