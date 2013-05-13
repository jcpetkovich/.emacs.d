
(require 'ess-site)

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'visual ess-mode-map
       (kbd "<tab>") 'indent-for-tab-command
       (kbd "C-d") 'evil-scroll-down)
     (evil-declare-key 'normal inferior-ess-mode-map
       (kbd "C-d") 'evil-scroll-down)))

(add-hook 'R-mode-hook
          (lambda ()
            (local-set-key (kbd "M-;") 'comment-dwim)))


(provide 'setup-r)
