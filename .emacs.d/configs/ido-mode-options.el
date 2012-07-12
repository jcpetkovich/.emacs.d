(eval-after-load "ido"
  '(progn
     (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-word-updir)))