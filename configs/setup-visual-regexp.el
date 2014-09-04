(require-package 'visual-regexp)
(require-package 'visual-regexp-steroids)

(global-set-key (kbd "M-%") 'vr/select-query-replace)
(global-set-key (kbd "A-C-5") 'vr/select-mc-mark)

(require 'visual-regexp)

(provide 'setup-visual-regexp)
