;; =============================================================
;; Evil keybindings
;; =============================================================

(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/evil")))
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "site-lisp/undo-tree")))

;;; Some versions of evil need these set before it's loaded
(setq evil-want-C-i-jump nil
      evil-want-C-u-scroll t)

(require-package 'browse-kill-ring)
(require 'undo-tree)
(require 'my-defuns)
(require 'evil)

(evil-mode 1)

(global-set-key (kbd "C-w") 'backward-kill-word)
(define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)

(--each '(normal insert)
  (evil-declare-key it global-map
    (kbd "C-a") 'shrink-whitespace
    (kbd "M-a") 'grow-whitespace-around
    (kbd "C-M-a") 'shrink-whitespace-around
    (kbd "C-n") 'evil-next-line
    (kbd "C-p") 'evil-previous-line
    (kbd "C-l") 'copy-to-register
    (kbd "C-+") 'increment-register
    (kbd "<f6>") 'projectile-compile-project
    (kbd "C-M-<backspace>") 'paredit-backward-delete
    (kbd "<f7>") 'compile
    (kbd "<f8>") 'recompile))

(--each '(normal visual motion)
  (evil-declare-key it global-map
    (kbd "zu") 'universal-argument))

(--each '(normal visual)
  (evil-declare-key it global-map
    (kbd "+") 'next-line-with-meat
    (kbd "_") 'previous-line-with-meat))

(--each '(normal visual)
  (evil-declare-key it dired-mode-map
    (kbd "+") 'dired-create-directory))

(evil-declare-key (quote normal) view-mode-map
  (kbd "q") 'View-quit)

(evil-define-command evil-ido-find-file (file)
  "Same as `evil-edit' but fall back to helm-find-files with no
file instead of revert."
  :repeat nil
  :move-point nil
  (interactive "<f>")
  (if file
      (find-file file)
    (helm-find-files-1 default-directory)))

;; Edit should be mapped to something smarter than evil's default
(evil-ex-define-cmd "e[dit]" 'evil-ido-find-file)

;; I prefer looking for symbols rather than words.
(setq-default evil-symbol-word-search t)

(provide 'setup-evil)
