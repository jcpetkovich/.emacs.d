;; Prelude
(setq load-prefer-newer t)

;; =============================================================
;; Load Path
;; =============================================================
(defconst prog-mode-configs-directory (expand-file-name (concat user-emacs-directory "mode-configs")))
(defconst ui-configs-directory (expand-file-name (concat user-emacs-directory "ui-configs")))
(defconst user-packages-directory (expand-file-name (concat user-emacs-directory "user-packages")))
(defconst site-lisp-directory (expand-file-name (concat user-emacs-directory "site-lisp")))
(add-to-list 'load-path prog-mode-configs-directory)
(add-to-list 'load-path ui-configs-directory)
(add-to-list 'load-path user-packages-directory)
(add-to-list 'load-path site-lisp-directory)

;; Add user packages to load-path
(let ((default-directory user-packages-directory))
  (normal-top-level-add-subdirs-to-load-path))

;; =============================================================
;; Bootstrapping elpa/req-package...
;; =============================================================
(require 'package)

(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.org/packages/"))
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

;; Org mode is still picky about when it's compiled
(require 'init-org-mode)

(req-package-force load-dir
  :init
  (let ((load-dirs (list ui-configs-directory
                         prog-mode-configs-directory)))
    (load-dirs)))

;; Fire off req!
(req-package-finish)

;; =============================================================
;; Custom Set Variables
;; =============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
