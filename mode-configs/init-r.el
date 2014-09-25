;; init-r.el - Setup emacs for editing R code.

(req-package ess-R-data-view
  :require ess)

(req-package ess
  :require (auto-complete evil)
  :init (require 'ess-site)
  :config
  (progn
    (bind-key "M-;" 'comment-dwim-2 ess-mode-map)

    (setq ess-pdf-viewer-pref "zathura")

    ;; Fix evil bindings
    (evil-declare-key 'visual ess-mode-map
      (kbd "<tab>") 'indent-for-tab-command
      (kbd "C-d") 'evil-scroll-down
      (kbd ",") 'ess-eval-region)
    (evil-declare-key 'normal inferior-ess-mode-map
      (kbd "C-d") 'evil-scroll-down)
    (evil-declare-key 'normal ess-help-mode-map
      (kbd "Q") 'ess-help-quit
      (kbd "q") 'ess-help-quit)

    (add-hook 'R-mode-hook
              (defun user-utils/R-whitespace-config ()
                (set (make-local-variable 'whitespace-style)
                     (remove 'empty whitespace-style))))

    (add-hook 'ess-mode-hook 'completion/use-auto-complete-instead)))

(req-package ess-noweb
  :require ess
  :config
  (progn
    (defun ess-noweb-post-command-function ()
      "The hook being run after each command in noweb mode."
      (condition-case err
          (ess-noweb-select-mode)
        (error)))))

(req-package helm-R
  :require (ess helm)
  :defer t
  :commands helm-for-R)

(provide 'init-r)
