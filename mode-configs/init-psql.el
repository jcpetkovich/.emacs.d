;; init-psql.el - Setup postgres interaction

(req-package sql-mode
  :mode ("\.psql$" . sql-mode))

(provide 'init-psql)
