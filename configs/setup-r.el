
(require-package 'ess)
(require-package 'ess-R-data-view)
(require 'ess-site)
(require 'setup-evil)
(require 'setup-whitespace-mode)

(evil-declare-key 'visual ess-mode-map
  (kbd "<tab>") 'indent-for-tab-command
  (kbd "C-d") 'evil-scroll-down
  (kbd ",") #'ess-eval-region)
(evil-declare-key 'normal inferior-ess-mode-map
  (kbd "C-d") 'evil-scroll-down)
(evil-declare-key 'normal ess-help-mode-map
  (kbd "Q") 'ess-help-quit
  (kbd "q") 'ess-help-quit)

(add-hook 'R-mode-hook
          (lambda ()
            (local-set-key (kbd "M-;") 'comment-dwim)
            (setq ess-pdf-viewer-pref "zathura")
            (set (make-local-variable 'whitespace-style)
                (remove 'empty whitespace-style))))

(defun ess-noweb-post-command-function ()
  "The hook being run after each command in noweb mode."
  (condition-case err
      (ess-noweb-select-mode)
    (error)))

(provide 'setup-r)
