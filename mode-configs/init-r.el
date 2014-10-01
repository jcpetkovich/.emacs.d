;; init-r.el - Setup emacs for editing R code.

(req-package ess-R-data-view
  :require ess)

(req-package ess
  :require (evil)
  :init (require 'ess-site)
  :config
  (progn
    (bind-key "M-;" 'comment-dwim-2 ess-mode-map)

    (setq-default
     ess-pdf-viewer-pref "zathura"
     ess-R-font-lock-keywords '((ess-R-fl-keyword:modifiers . t)
                                (ess-R-fl-keyword:fun-defs . t)
                                (ess-R-fl-keyword:keywords . t)
                                (ess-R-fl-keyword:assign-ops . t)
                                (ess-R-fl-keyword:constants . t)
                                (ess-fl-keyword:fun-calls . t)
                                (ess-fl-keyword:numbers . t)
                                (ess-fl-keyword:operators . t)
                                (ess-fl-keyword:delimiters)
                                (ess-fl-keyword:= . t)
                                (ess-R-fl-keyword:F&T . t))
     ess-default-style 'OWN
     ess-own-style-list '((ess-indent-level . 4)
                          (ess-continued-statement-offset . 4)
                          (ess-brace-offset . 0)
                          (ess-expression-offset . 4)
                          (ess-else-offset . 0)
                          (ess-brace-imaginary-offset . 0)
                          (ess-continued-brace-offset . 0)
                          (ess-arg-function-offset . 2)
                          (ess-close-brace-offset . 0))

     inferior-R-font-lock-keywords '((ess-S-fl-keyword:prompt . t)
                                     (ess-R-fl-keyword:messages . t)
                                     (ess-R-fl-keyword:modifiers . t)
                                     (ess-R-fl-keyword:fun-defs . t)
                                     (ess-R-fl-keyword:keywords . t)
                                     (ess-R-fl-keyword:assign-ops . t)
                                     (ess-R-fl-keyword:constants . t)
                                     (ess-fl-keyword:matrix-labels . t)
                                     (ess-fl-keyword:fun-calls)
                                     (ess-fl-keyword:numbers . t)
                                     (ess-fl-keyword:operators . t)
                                     (ess-fl-keyword:delimiters)
                                     (ess-fl-keyword:= . t)
                                     (ess-R-fl-keyword:F&T . t)))

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
