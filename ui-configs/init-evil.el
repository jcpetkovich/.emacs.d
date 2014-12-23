;; =============================================================
;; Evil keybindings
;; =============================================================

(req-package browse-kill-ring
  :config
  (setq-default browse-kill-ring-quit-action 'save-and-restore))

(req-package evil
  :require (undo-tree browse-kill-ring)
  :defer t
  :init
  (progn
    (setq-default evil-want-C-i-jump nil
                  evil-want-C-u-scroll t
                  evil-symbol-word-search t
                  evil-cross-lines t
                  evil-default-cursor t
                  evil-esc-delay 0)
    (require 'evil)
    (evil-mode 1))
  :config
  (progn
    (--each '(normal insert)
      (evil-declare-key it global-map
        (kbd "C-n") 'evil-next-line
        (kbd "C-p") 'evil-previous-line))

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

    (evil-declare-key 'normal visual-line-mode-map
      (kbd "j") 'evil-next-visual-line
      (kbd "k") 'evil-previous-visual-line
      (kbd "$") 'evil-end-of-visual-line
      (kbd "0") 'evil-beginning-of-visual-line)

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
  :init (global-evil-surround-mode 1)
  :config (bind-key "s" 'evil-surround-region evil-visual-state-map))

(provide 'init-evil)
