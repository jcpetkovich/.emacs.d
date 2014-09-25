;; user-utils.el - Small, self-contained tools.

;; Toggle fullscreen mode
(defalias 'toggle-fullscreen 'user-utils/toggle-fullscreen)
(defun user-utils/toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

(defun user-utils/force-revert ()
  (interactive)
  (revert-buffer t t))

(defalias 'move-cursor-next-pane 'user-utils/move-cursor-next-pane)
(defun user-utils/move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defalias 'move-cursor-previous-pane 'user-utils/move-cursor-previous-pane)
(defun user-utils/move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(eval-after-load "evil"
  '(progn
     (evil-define-motion next-line-with-meat (count)
       :type line

       (next-line)
       (while (not (line-has-meat-p))
         (next-line))
       (evil-insert-line (or count 1)))

     (evil-define-motion previous-line-with-meat (count)
       :type line

       (previous-line)
       (while (not (line-has-meat-p))
         (previous-line))
       (evil-append-line (or count 1)))))


(provide 'user-utils)