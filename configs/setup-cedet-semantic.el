;;; setup-cedet-semantic.el - setup cedet and semantic

(require 'semantic)

(global-semanticdb-minor-mode 1)

(setq-default global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(provide 'setup-cedet-semantic)
