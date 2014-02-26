;; =============================================================
;; Evil keybindings
;; =============================================================

(add-to-list 'load-path "~/.emacs.d/site-lisp/evil")
(add-to-list 'load-path "~/.emacs.d/site-lisp/undo-tree")

(require-package 'browse-kill-ring)

(require 'undo-tree)

(global-set-key (kbd "C-w") 'backward-kill-word)

(eval-after-load "evil"
  '(progn
     (require 'my-defuns)

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
         (kbd "<f6>") 'browse-kill-ring
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
       "Same as `evil-edit' but fall back to ido-find-file with no
file instead of revert."
       :repeat nil
       :move-point nil
       (interactive "<f>")
       (if file
           (find-file file)
         (ido-find-file)))

     ;; Edit should be mapped to something smarter than evil's default
     (evil-ex-define-cmd "e[dit]" 'evil-ido-find-file)
     
     ;; I prefer looking for symbols rather than words.
     (defalias 'evil-find-word 'evil-find-symbol)))

(provide 'setup-evil)
