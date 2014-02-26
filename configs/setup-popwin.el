;; setup-popwin.el - configure helm and related packages

(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)

(setq popwin:special-display-config '((help-mode :height 40)
                                      ("^Calc: .*$" :regexp t :height 30)))




(provide 'setup-popwin)
