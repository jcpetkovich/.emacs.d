
(require 'setup-package)

(require 'find-file-in-project)
(global-set-key (kbd "C-x f") 'find-file-in-project)
(push "*.tex" ffip-patterns)

;; (defadvice find-file-in-project (before turn-on-ido-vertical activate)
;;   (ido-vertical-mode 1))

;; (defadvice find-file-in-project (after turn-off-ido-vertical activate)
;;   (ido-vertical-mode 0))


(defadvice grep-mode (after grep-register-match-positions activate)
  (add-hook 'compilation-filter-hook 'grep-register-match-positions nil t))

(provide 'setup-ffip)
