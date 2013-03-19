
(defadvice paredit-close-round (after paredit-close-and-indent activate)
  (cleanup-buffer))

(provide 'setup-paredit)
