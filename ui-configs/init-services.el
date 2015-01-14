;; init-services.el - Setup services used by emacs

(req-package prodigy
  :config
  (progn
    (add-to-list 'evil-emacs-state-modes 'prodigy-mode)
    (prodigy-define-service
      :name "Leiningen"
      :command "lein"
      :args '("repl" ":headless")
      :cwd user-emacs-directory
      :tags '(clojure)
      :stop-signal 'int
      :kill-process-buffer-on-stop t)))

(provide 'init-services)
