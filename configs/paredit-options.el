
(defadvice paredit-close-round (after paredit-close-and-indent activate)
  (cleanup-buffer))
