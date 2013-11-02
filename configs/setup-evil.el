;; =============================================================
;; Evil keybindings
;; =============================================================

(add-to-list 'load-path "~/.emacs.d/site-lisp/evil")
(add-to-list 'load-path "~/.emacs.d/site-lisp/undo-tree")

(require 'undo-tree)

(global-set-key (kbd "C-w") 'backward-kill-word)

(eval-after-load "evil"
  '(progn

     (evil-define-motion next-line-with-meat (count)
       :type line

       (while (not (line-has-meat-p))
         (next-line))
       (evil-insert-line (or count 1)))

     (evil-define-motion previous-line-with-meat (count)
       :type line

       (while (not (line-has-meat-p))
         (previous-line))
       (evil-append-line (or count 1)))

     (define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)

     (mapcar (lambda (state)
               (evil-declare-key state global-map
                 (kbd "C-a") 'shrink-whitespace
                 (kbd "M-a") 'grow-whitespace
                 (kbd "C-n") 'evil-next-line
                 (kbd "C-p") 'evil-previous-line
                 (kbd "C-l") 'copy-to-register
                 (kbd "C-+") 'increment-register
                 (kbd "<f6>") 'browse-kill-ring
                 (kbd "C-M-<backspace>") 'paredit-backward-delete
                 (kbd "<f7>") 'compile
                 (kbd "<f8>") 'recompile))
             '(normal insert))

     (dolist (mode '(normal visual motion))
       (evil-declare-key mode global-map
         (kbd "zu") 'universal-argument
         (kbd "+") 'next-line-with-meat
         (kbd "_") 'previous-line-with-meat))

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

;;; Edit should be mapped to something smarter than evil's default
     (evil-ex-define-cmd "e[dit]" 'evil-ido-find-file)))

(provide 'setup-evil)
