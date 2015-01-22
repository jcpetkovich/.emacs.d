;; init-evil.el - Setup emacs for evil.

;; =============================================================
;; Evil Deps, even evil needs help
;; =============================================================
(req-package browse-kill-ring
  :config
  (setq-default browse-kill-ring-quit-action 'save-and-restore))

(req-package guide-key
  :config
  (progn
    (setq-default guide-key/guide-key-sequence t)
    (guide-key-mode 1)))

;; =============================================================
;; Surround and conquer
;; =============================================================
(req-package evil-surround
  :require (evil)
  :init (global-evil-surround-mode 1)
  :config (bind-key "s" 'evil-surround-region evil-visual-state-map))

;; =============================================================
;; Evil Arrrg
;; =============================================================
(req-package evil-args
  :require evil
  :init
  (progn
    ;; bind evil-args text objects
    (bind-key "a" 'evil-inner-arg evil-inner-text-objects-map)
    (bind-key "a" 'evil-outer-arg evil-outer-text-objects-map)

    ;; bind evil-forward/backward-args
    (bind-keys :map evil-normal-state-map
               ("L" . evil-forward-arg)
               ("H" . evil-backward-arg))

    (bind-keys :map evil-motion-state-map
               ("L" . evil-forward-arg)
               ("H" . evil-backward-arg))

    ;; bind evil-jump-out-args
    (bind-key "K" 'evil-jump-out-args evil-normal-state-map)))

;; =============================================================
;; Evil Match, to start a fire
;; =============================================================
(req-package evil-matchit
  :require evil
  :config
  (global-evil-matchit-mode 1))

;; =============================================================
;; Disheartening and disrespectful, whispers from the evil god
;; =============================================================
(req-package evil-nerd-commenter
  :require evil
  :config
  (evilnc-default-hotkeys))

;; =============================================================
;; What is an evil god without an evil lingua franca
;; =============================================================
(req-package evil-lisp-state
  :require evil)

;; =============================================================
;; The evil god himself
;; =============================================================
(req-package evil-god-state
  :require evil)

;; =============================================================
;; Behold, evil incarnate
;; =============================================================
(req-package evil
  :require (undo-tree browse-kill-ring)
  :commands (evil-declare-key evil-define-key)
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

(provide 'init-evil)
