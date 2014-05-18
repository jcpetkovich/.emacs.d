
(require-package 'ess)
(require-package 'ess-R-data-view)
(require 'ess-site)
(require 'setup-evil)

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
            (setq ess-pdf-viewer-pref "zathura")))


(provide 'setup-r)
