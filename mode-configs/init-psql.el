
(setq auto-mode-alist (cons '("\.psql$" . sql-mode) auto-mode-alist))
(autoload 'sql-mode "sql" "SQL editing mode" t)

(provide 'init-psql)
