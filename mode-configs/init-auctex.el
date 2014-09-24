;; init-auctex.el - Setup emacs for editing latex.

(req-package auctex
  :require evil
  :config
  (progn
    (bind-keys :map LaTeX-mode-map
               ("C-c DEL" . user-auctex/delete-env-pair)
               ("<M-return>" . LaTeX-insert-item)
               ("C-c C-f" . LaTeX-find-matching-end)
               ("C-c C-b" . LaTeX-find-matching-begin))

    (evil-define-key 'visual
      LaTeX-mode-map (kbd "\"") 'sp--self-insert-command)

    (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'reftex-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'orgtbl-mode)

    (setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))

    (push '("zathura" "zathura -s -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf")
          TeX-view-program-list)
    (push '(output-pdf "zathura")
          TeX-view-program-selection)

    (defun user-auctex/check-item-entry ()
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
      (user-auctex/check-item-entry))


    (defun user-auctex/delete-env-pair ()
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
        (kill-line)))))

(provide 'init-auctex)
