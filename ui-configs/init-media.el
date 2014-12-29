;; init-media.el - Setup emacs to play media

(req-package emms
  :config
  (progn
    (emms-standard)
    (setq emms-player-list '(emms-player-mpd))
    (emms-devel)
    (defadvice emms-browser-mode (after use-emacs-mode-please activate)
      (evil-emacs-state))
    (--each '(emms-browser-mode emms-playlist-mode)
      (add-to-list 'evil-emacs-state-modes it))))
