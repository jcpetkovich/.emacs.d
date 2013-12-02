
;; =============================================================
;; Ensure we're ready to handle files that are gpg encrypted
;; =============================================================
(require 'epa-file)
(epa-file-enable)

;; =============================================================
;; Load Path
;; =============================================================
(defconst user-emacs-directory "~/.emacs.d/")
(defconst ini-configs-directory (expand-file-name (concat user-emacs-directory "configs")))
(defconst ini-defuns-directory (expand-file-name (concat user-emacs-directory "defuns")))
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path ini-configs-directory)
(add-to-list 'load-path ini-defuns-directory)

;; =============================================================
;; Essential dependencies
;; =============================================================

;;; `s' and `dash' are required by most other config files.
(add-to-list 'load-path "~/.emacs.d/site-lisp/dash")
(add-to-list 'load-path "~/.emacs.d/site-lisp/s")

(condition-case err
    (progn
      (require 'dash)
      (require 's)
      (dash-enable-font-lock))
  (error
   (message "Error: %s" (error-message-string err))
   (message "Error: Could not load core deps, did you run: git submodule update --init --recursive")))

;; =============================================================
;; Load package.el functions
;; =============================================================
(require 'package-defuns)

;; =============================================================
;; Alright, let's get this started!
;; =============================================================
(defvar ini-loaded '())

(defun load-with-message (filespec)
  (message (concat "Loading " filespec))
  (load filespec)
  (push filespec ini-loaded))

(--each (directory-files ini-configs-directory nil "^setup.*\\.el$")
  (load-with-message it))

(when (file-exists-p my-notes-file)
  (find-file my-notes-file))

;; =============================================================
;; Variables set by emacs
;; =============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
