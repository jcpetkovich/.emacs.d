;; ============================================================= 
;; All options for standard keybindings go in here
;; ============================================================= 

;; ============================================================= 
;; Set nice keybindings (combined with viper/vimpulse)
;; ============================================================= 
(windmove-default-keybindings 'meta)
(global-set-key "\C-x\C-b" 'switch-to-buffer)
(global-set-key (kbd "M-p") 'windmove-up)
(global-set-key (kbd "M-n") 'windmove-down)
(global-set-key (kbd "M-j") 'move-cursor-next-pane)
(global-set-key (kbd "M-k") 'move-cursor-previous-pane)
(global-set-key (kbd "M-l") 'shrink-window-horizontally)
(global-set-key (kbd "M-h") 'shrink-window)
(global-set-key (kbd "M-t") 'call-keyword-completion)
(global-set-key (kbd "M-e") 'dabbrev-expand)
(global-set-key (kbd "C-<tab>") 'folding-toggle-show-hide)
(global-set-key (kbd "M-s") 'move-cursor-next-pane)
(global-set-key (kbd "M-S") 'move-cursor-previous-pane)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-!") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-@") 'split-window-horizontally)
(global-set-key (kbd "<f5>") 'toggle-fullscreen)
(global-set-key (kbd "<f11>") 'align-regexp)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-ce" 'fc-eval-and-replace)
(global-set-key (kbd "C-.") 'ecb-goto-window-directories)

;; ============================================================= 
;; Hooks for fixing keybindings in different modes
;; ============================================================= 

;; Hook for correcting behaviour in info mode
(add-hook 'Info-mode-hook
          (lambda ()
            (define-key Info-mode-map (kbd "M-s") 'other-window))) ; was Info-search

;; Hook for correcting behaviour in text mode
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map (kbd "M-s") 'other-window) ; was center-line
            (define-key text-mode-map (kbd "M-S") 'nil))) ; was center-paragraph
          
;; Hook for correcting behaviour in org mode
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "M-e") 'dabbrev-expand))) ; was org-move-paragraph

;; Hook for correcting behaviour in html mode
(add-hook 'html-mode-hook
          (lambda ()
            (define-key html-mode-map (kbd "M-s") 'other-window)))

;; ============================================================= 
;; Custom Functions
;; ============================================================= 

;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;; Toggle fullscreen mode
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

(defun newline-on-next-line ()
  "Like vim's 'o'"
  (interactive)
  (end-of-line)
  (newline))

(defun newline-on-previous-line ()
  "Like vim's 'O'"
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line))

(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(defun call-keyword-completion ()
  "Call the command that has keyboard shortcut M-TAB."
  (interactive)
  (call-interactively (key-binding (kbd "M-TAB"))))

(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun shrink-whitespaces ()
  "Remove white spaces around cursor to just one or none.
If current line contains non-white space chars, then shrink any whitespace char surrounding cursor to just one space.
If current line does not contain non-white space chars, then remove blank lines to just one."
  (interactive)
  (let (cursor-point
        line-has-meat-p  ; current line contains non-white space chars
        spaceTabNeighbor-p
        whitespace-begin whitespace-end
        space-or-tab-begin space-or-tab-end
        line-begin-pos line-end-pos)
    (save-excursion
      ;; todo: might consider whitespace as defined by syntax table, and also consider whitespace chars in unicode if syntax table doesn't already considered it.
      (setq cursor-point (point))
      (setq spaceTabNeighbor-p 
            (if (or (looking-at " \\|\t") (looking-back " \\|\t"))
                t 
              nil))
      (move-beginning-of-line 1) 
      (setq line-begin-pos (point))
      (move-end-of-line 1) 
      (setq line-end-pos (point))
      ;;       (re-search-backward "\n$") (setq line-begin-pos (point) )
      ;;       (re-search-forward "\n$") (setq line-end-pos (point) )
      (setq line-has-meat-p 
            (if (< 0 (count-matches "[[:graph:]]" line-begin-pos line-end-pos))
                t
              nil))
      (goto-char cursor-point)
      (skip-chars-backward "\t ")
      (setq space-or-tab-begin (point))
      (skip-chars-backward "\t \n")
      (setq whitespace-begin (point))
      (goto-char cursor-point) 
      (skip-chars-forward "\t ")
      (setq space-or-tab-end (point))
      (skip-chars-forward "\t \n")
      (setq whitespace-end (point)))
    (if line-has-meat-p
        (progn 
          (when spaceTabNeighbor-p
            (delete-region space-or-tab-begin space-or-tab-end)
            (insert " ")))

      (progn
        ;;         (delete-region whitespace-begin whitespace-end)
        ;;         (insert "\n")
        (delete-blank-lines)))))

;; ============================================================= 
;; Cruft
;; ============================================================= 

;; (defun code-section-heading ()
;;   (interactive)
;;   (save-excursion
;;     (move-beginning-of-line 1)
;;     (setq line-begin-pos (point))
;;     (move-end-of-line 1)
;;     (setq line-end-pos (point))
;;     (setq num-chars-in-line (count-matches "[[:graph:] ]" line-begin-pos line-end-pos))
;;     (move-beginning-of-line 1)
;;     (insert-char 61 20)
;;     (insert-char 32 1)
;;     (move-end-of-line 1)
;;     (insert-char 32 1)
;;     (insert-char 61 (- 20 num-chars-in-line))
;;     (print num-chars-in-line)))

