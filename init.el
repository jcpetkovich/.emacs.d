;; =============================================================
;; Load Path
;; =============================================================
(defconst prog-mode-configs-directory (expand-file-name (concat user-emacs-directory "mode-configs")))
(defconst ui-configs-directory (expand-file-name (concat user-emacs-directory "ui-configs")))
(defconst user-packages-directory (expand-file-name (concat user-emacs-directory "user-packages")))
(defconst site-lisp-directory (expand-file-name (concat user-emacs-directory "site-lisp")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path prog-mode-configs-directory)
(add-to-list 'load-path ui-configs-directory)
(add-to-list 'load-path user-packages-directory)
(add-to-list 'load-path site-lisp-directory)

;; Add user packages to load-path
(let ((default-directory user-packages-directory))
  (normal-top-level-add-subdirs-to-load-path))

;; Revise keybindings:
;;; Keybindings/editing (global-key-bindings.el) (needs revising)
;;; Keybindings? (init-evil.el) (needs revising)

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
  (let ((load-dirs (list ui-configs-directory
                         prog-mode-configs-directory)))
    (load-dirs)))

;; And now, the keybindings
(require 'global-key-bindings)

;; Fire off req!
(req-package-finish)

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Main ideas for rewrite

;; (done) 1. custom.el should be reduced to its minimum, essentially only the
;; theme should be included

;; (done) 2. switch everything to use req-package or use-package.

;; 3. drop all my keybinding extensions and redesign them from scratch
;; based on the things I've learned.

;; (done) 4. Trim unused cruft.

;; (done) 5. change order of loaded files, mainly putting global keybindings
;; at the end, and manually load them.

;; (done) 6. Consider methods of consolidating customizations to mode/package
;; keybindings in a way that makes sense.

;; 7. regain some of the emacs keybindings I've removed, particularly
;; the ones involved in movement.

;; (done) 8. redefine personal custom things under a unified namespace, e.g.,
;; sanityinc

;; (done) 9. Fix yasnippet enabling of auto-complete mode

;; (done) 10. Fix Makefile
