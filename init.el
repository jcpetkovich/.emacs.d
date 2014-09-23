;; =============================================================
;; Load Path
;; =============================================================
(defconst prog-mode-configs-directory (expand-file-name (concat user-emacs-directory "mode-configs")))
(defconst ui-configs-directory (expand-file-name (concat user-emacs-directory "ui-configs")))
(defconst user-packages-directory (expand-file-name (concat user-emacs-directory "user-packages")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path prog-mode-configs-directory)
(add-to-list 'load-path ui-configs-directory)
(add-to-list 'load-path user-packages-directory)

;; Config files which could be absorbed by emacs functionality

;;; Keybindings/editing
;; ace-jump-mode
;; helm
;; multiple-cursors
;; paredit
;; req
;; visual-regexp

;;; Keybindings?
;; evil
;; evil-god
;; evil-surround
;; ffip

;;; Completion
;; auto-complete
;; company
;; hippie-expand
;; yasnippet

;;; Programming
;; cedet-semantic
;; flycheck
;; whitespace-mode
;; projectile
;; magit

;;; Cosmetic
;; diminish
;; parenface
;; theme

;;; Non editing functionality
;; dired
;; email
;; erc
;; eshell
;; grep
;; twittering-mode

;;; Delete
;; popwin


;;;

;; =============================================================
;; Bootstrapping elpa/req-package...
;; =============================================================
(require 'package)

(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives melpa)
(package-initialize)

(when (not (package-installed-p 'req-package))
  (when (not (assoc 'req-package package-archive-contents))
    (package-refresh-contents))
  (package-install 'req-package))

(require 'req-package)

;; =============================================================
;; Alright, let's get this started!
;; =============================================================
(req-package-force load-dir
  :init
  (let ((load-dirs (list ui-configs-directory prog-mode-configs-directory)))
    (load-dirs)))

;; And now, the keybindings
(require 'global-key-bindings)

;; Fire off req!
(req-package-finish)

;; Open my notes if they're there
(when (file-exists-p my-notes-file)
  (find-file my-notes-file))

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Main ideas for rewrite

;; 1. custom.el should be reduced to its minimum, essentially only the
;; theme should be included

;; 2. switch everything to use req-package or use-package.

;; 3. drop all my keybinding extensions and redesign them from scratch
;; based on the things I've learned.

;; 4. Trim unused cruft.

;; 5. change order of loaded files, mainly putting global keybindings
;; at the end, and manually load them.

;; 6. Consider methods of consolidating customizations to mode/package
;; keybindings in a way that makes sense.

;; 7. regain some of the emacs keybindings I've removed, particularly
;; the ones involved in movement.

;; 8. redefine personal custom things under a unified namespace, e.g.,
;; sanityinc

;; Sketch of the new process:
;; 1. Setup path, setup package.el
;; 2. load/install req-package
;; 3. use req-package to grab/configure all packages
;; 4. set package/mode keybindings
;; 5. set global keybindings
;; 6. setup custom.el
