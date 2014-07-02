;;; setup-req.el - req related configurations

;;; This stuff is pretty experimental.

;;; key bindings to select file or thing around point
(global-set-key [f12] (lambda ()(interactive) (
  shell-command (concat
  "req -menu"
  " -f emacs"
  " -w \"$(dirname '" (buffer-file-name) "')\""
  " " (buffer-substring (region-beginning) (region-end) )))))

(global-set-key [f12] (lambda ()(interactive) (
  shell-command (concat
  "req"
  " -f emacs"
  " -w \"$(dirname '" (buffer-file-name) "')\""
  " " (buffer-substring (region-beginning) (region-end) )))))
; thing-at-point args to consider: 'filename 'url 'email 'sentence 'word 'line
(global-set-key [f12] (lambda ()(interactive) (
  shell-command (concat
  "req -menu"
  " -f emacs"
  " -w \"$(dirname '" (buffer-file-name) "')\""
  " " (thing-at-point 'filename)))))
(global-set-key [f12] (lambda ()(interactive) (
  shell-command (concat
  "req"
  " -f emacs"
  " -w \"$(dirname '" (buffer-file-name) "')\""
  " " (thing-at-point 'filename)))))

(provide 'setup-req)
