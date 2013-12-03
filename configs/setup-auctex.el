
(require-package 'auctex)

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))

(eval-after-load "latex"
  '(progn
     (push '("zathura" "zathura -s -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf")
           TeX-view-program-list)
     (push '(output-pdf "zathura")
           TeX-view-program-selection)))


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


(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map (kbd "C-c DEL") 'delete-env-pair)))

(defun delete-env-pair ()
  "Deletes the \begin{} \end{} pair at point."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (looking-at "\s*\\\\end")
        (progn
          (save-excursion
            (LaTeX-find-matching-begin)
            (beginning-of-line)
            (kill-line)))
      (if (looking-at "\s*\\\\begin")
          (progn
            (save-excursion
              (end-of-line)
              (LaTeX-find-matching-end)
              (beginning-of-line)
              (kill-line)))))
    (beginning-of-line)
    (kill-line)))

(eval-after-load "evil"
  '(progn
     (evil-declare-key 'insert LaTeX-mode-map
       (kbd "<M-return>" ) 'LaTeX-insert-item)
     (-each '(normal insert visual)
            (lambda (mode)
              (evil-declare-key mode LaTeX-mode-map
                (kbd "C-c C-f") 'LaTeX-find-matching-end
                (kbd "C-c C-b") 'LaTeX-find-matching-begin)))))

(provide 'setup-auctex)
