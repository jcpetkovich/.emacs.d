;; setup-twittering-mode.el - configure twittering mode

(req-package twittering-mode
  :commands twit
  :config
  (setq twittering-icon-mode t
        twittering-use-master-password t))

(provide 'init-twittering-mode)
