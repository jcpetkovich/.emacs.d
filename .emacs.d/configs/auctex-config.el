(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'reftex-mode)

(defun check-item-entry ()
  "This function is meant to be used as advice for the
`LaTeX-insert-item' function. The purpose behind this is to delete
the extra blank line that is naively added by `LaTeX-insert-item'
when not already on an item line."
  (interactive)
  (save-excursion
    ;; Backward one line, check if it happened if the line we're
    ;; looking is empty, delete it
    (if (and (= (forward-line -1) 0)
             (looking-at "^\\s-*$"))
        (kill-line))))

(defadvice LaTeX-insert-item (after remove-whitespace-first-item activate)
  "This advice is meant to fix the issue where an extra blank
line is naively added by `LaTeX-insert-item' when not already on
an item line."
  (check-item-entry))

;;; might be able to do something cool like delete matching begin..end
;;; tag with this:
;; (let* ((in-comment (TeX-in-commented-line))
;;        (comment-prefix (and in-comment (TeX-comment-prefix)))
;;        (arg 1))
  
;;   (while (and (/= arg 0)
;;               (re-search-backward
;;                "\\\\\\(begin\\|end\\) *{ *\\([A-Za-z*]+\\) *}" nil t))
;;     (when (or (and LaTeX-syntactic-comments
;;                    (eq in-comment (TeX-in-commented-line))
;;                    (or (not in-comment)
;;                        ;; Consider only matching prefixes in the
;;                        ;; commented case.
;;                        (string= comment-prefix (TeX-comment-prefix))))
;;               (and (not LaTeX-syntactic-comments)
;;                    (not (TeX-in-commented-line))))
;;       (setq arg (if (string= (match-string 1) "end") (1+ arg) (1- arg)))))
;;   (if (/= arg 0)
;;       "document"
;;     (match-string-no-properties 2)))
