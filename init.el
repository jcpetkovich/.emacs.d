;; =============================================================
;; Load Path
;; =============================================================
(defconst config-directory (expand-file-name (concat user-emacs-directory "configs")))
(defconst defuns-directory (expand-file-name (concat user-emacs-directory "defuns")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path config-directory)
(add-to-list 'load-path defuns-directory)

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
(req-package-force load-dir :init (load-dir-one config-directory))

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
