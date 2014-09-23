;;; setup-req.el - req related configurations

;;; This stuff is pretty experimental.

;;; key bindings to select file or thing around point
(global-set-key [f9]
                (lambda ()(interactive)
                  (shell-command (concat
                            "req "
                            " -f emacs"
                            " -w \"$(dirname '" (buffer-file-name) "')\""
                            " '" (buffer-substring (region-beginning) (region-end) ) "'"))))

(provide 'init-req)
