(require 'ess-site)

(add-hook 'R-mode-hook
          (lambda ()
            (vimpulse-local-set-key 'visual-state (kbd "<tab>") 'indent-for-tab-command)))
