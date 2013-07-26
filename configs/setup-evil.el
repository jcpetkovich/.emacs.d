;; =============================================================
;; Evil keybindings
;; =============================================================

(add-to-list 'load-path "~/.emacs.d/site-lisp/evil")
(add-to-list 'load-path "~/.emacs.d/site-lisp/undo-tree")

(require 'undo-tree)

(global-set-key (kbd "C-w") 'backward-kill-word)

(eval-after-load "evil"
  '(progn
     (define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)

     (mapcar (lambda (state)
               (evil-declare-key state global-map
                 (kbd "C-a") 'shrink-whitespaces
                 (kbd "C-n") 'evil-next-line
                 (kbd "C-p") 'evil-previous-line
                 (kbd "C-l") 'copy-to-register
                 (kbd "C-+") 'increment-register
                 (kbd "<f6>") 'browse-kill-ring
                 (kbd "C-M-<backspace>") 'paredit-backward-delete
                 (kbd "<f7>") 'compile
                 (kbd "<f8>") 'recompile))
             '(normal insert))

     (evil-declare-key (quote normal) view-mode-map
       (kbd "q") 'View-quit)))

(provide 'setup-evil)
