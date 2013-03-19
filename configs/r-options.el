(require 'ess-site)

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'visual ess-mode-map
                       (kbd "<tab>") 'indent-for-tab-command)))

(add-hook 'R-mode-hook
          (lambda ()
            (local-set-key (kbd "M-;") 'comment-dwim)))
