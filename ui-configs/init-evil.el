;; =============================================================
;; Evil keybindings
;; =============================================================

(req-package evil
  :require (undo-tree browse-kill-ring)
  :init
  (progn
    (setq-default evil-want-C-i-jump nil
                  evil-want-C-u-scroll t
                  evil-symbol-word-search t)
    (evil-mode 1))
  :config
  (progn
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


    (evil-define-command evil-helm-find-file (file)
      "Same as `evil-edit' but fall back to helm-find-files with no
file instead of revert."
      :repeat nil
      :move-point nil
      (interactive "<f>")
      (if file
          (find-file file)
        (helm-find-files-1 default-directory)))

    ;; Edit should be mapped to something smarter than evil's default
    (evil-ex-define-cmd "e[dit]" 'evil-helm-find-file)))

;; =============================================================
;; Evil God
;; =============================================================
(req-package evil-god-state
  :require evil)

;; =============================================================
;; Evil Surround
;; =============================================================
(req-package evil-surround
  :require (evil)
  :init (global-evil-surround-mode 1))

(provide 'init-evil)
