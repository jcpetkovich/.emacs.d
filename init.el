;; =============================================================
;; Load Path
;; =============================================================
(defconst ini-configs-directory (expand-file-name (concat user-emacs-directory "configs")))
(defconst ini-defuns-directory (expand-file-name (concat user-emacs-directory "defuns")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path ini-configs-directory)
(add-to-list 'load-path ini-defuns-directory)

;; =============================================================
;; Load package.el functions, now we can install things
;; =============================================================
(require 'package-defuns)

;; =============================================================
;; Essential dependencies
;; =============================================================

;;; `s' and `dash' are required by most other config files.
(require-package 'dash)
(require-package 's)

(condition-case err
    (progn
      (require 'dash)
      (require 's)
      (dash-enable-font-lock))
  (error
   (message "Error: %s" (error-message-string err))
   (message "Error: Could not load core deps, did you run: git submodule update --init --recursive")))

;; =============================================================
;; Alright, let's get this started!
;; =============================================================

;;; `org-mode' needs to be configured first
(require 'init-org-mode)

;;; require the rest of the config files!
(-map (lambda (filespec)
        (require (intern (s-chop-suffix ".el" filespec))))
      (directory-files ini-configs-directory nil "^init.*\\.el$"))

(when (file-exists-p my-notes-file)
  (find-file my-notes-file))

;; =============================================================
;; Variables set by emacs
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
