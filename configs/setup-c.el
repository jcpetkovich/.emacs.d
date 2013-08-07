
(require 'setup-package)
(require 'setup-dash)
(require 'dash)

(add-hook 'c-mode-hook (lambda () (abbrev-mode -1)))

;;; By default, follow bsd style
(setq-default c-default-style "bsd")

(setq linux-source-locations '("~/src/linux-trees"
                               "/usr/src/linux"))

;;; Linux kernel styling
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            ;; tab width 8 in C please
            (setq tab-width 8)
            (setq indent-tabs-mode t)
            (let ((filename (buffer-file-name)))

              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (-any-p (lambda (path) (string-match (expand-file-name path) filename))
                                 linux-source-locations))
                (smart-tabs-mode -1)
                (c-set-style "linux-tabs-only")))))

(smart-tabs-insinuate 'c)

(provide 'setup-c)
