;; init-markdown-mode.el - Setup emacs for editing markdown

(req-package markdown-mode
  :defer t
  :commands markdown-mode
  :init
  (--each '(("\\.md\\'" . markdown-mode)
            ("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist it)))

(provide 'init-markdown-mode)
