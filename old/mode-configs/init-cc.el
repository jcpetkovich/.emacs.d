;;; init-cc.el - C/C++ related configs

(req-package smart-tabs-mode
  :init (smart-tabs-insinuate 'c 'c++))

(req-package cc-mode
  :require smart-tabs-mode
  :commands (c-mode c++-mode)
  :init (progn
          (defun user-cc/default-language-standard (value)
            "C language standard to use for syntax checking through flycheck."
            (setf flycheck-gcc-language-standard value
                  flycheck-clang-language-standard value))
          (user-cc/default-language-standard "c99")

          (defun user-cc/default-include-path (value)
            "C language default include path for flycheck."
            (setf flycheck-gcc-include-path value
                  flycheck-clang-include-path (-concat '("/usr/lib/clang/3.5.0/include") value)))
          (user-cc/default-include-path '("/usr/include" "/usr/include/linux"))

          (defun user-cc/default-includes (value)
            "C language default includes for flycheck."
            (setf flycheck-gcc-includes value
                  flycheck-clang-includes value))
          (user-cc/default-includes nil))
  :config
  (progn
    (add-hook 'c-mode-hook (defun user-utils/turn-off-abbrev-mode ()
                             (abbrev-mode -1)))

    (defvar user-cc/linux-source-locations nil
      "Path's to linux source used for pattern matching.")

    ;; By default, follow bsd style
    (setq-default c-default-style "bsd"
                  user-cc/linux-source-locations '("~/src/linux-trees"
                                                   "/usr/src/linux"))

    (defun user-cc/c-lineup-arglist-tabs-only (ignored)
      "Line up argument lists by tabs, not spaces. This is mainly
for the Linux Kernel style guidelines."
      (let* ((anchor (c-langelem-pos c-syntactic-element))
             (column (c-langelem-2nd-pos c-syntactic-element))
             (offset (- (1+ column) anchor))
             (steps (floor offset c-basic-offset)))
        (* (max steps 1)
           c-basic-offset))))

  (add-hook 'c-mode-common-hook
            (defun user-cc/linux-source-styling ()
              ;; Add kernel style
              (c-add-style
               "linux-tabs-only"
               '("linux" (c-offsets-alist
                          (arglist-cont-nonempty
                           c-lineup-gcc-asm-reg
                           user-cc/c-lineup-arglist-tabs-only))))))

  (add-hook 'c-mode-hook
            (defun user-cc/setup-default-c-indentation ()
              ;; tab width 8 in C please
              (set (make-local-variable 'tab-width) 8)
              (set (make-local-variable 'indent-tabs-mode) t)
              (let ((filename (buffer-file-name)))

                ;; Enable kernel mode for the appropriate files
                (when (and filename
                           (-any-p (lambda (path) (string-match (expand-file-name path) filename))
                                   user-cc/linux-source-locations))
                  (smart-tabs-mode -1)
                  (c-set-style "linux-tabs-only")))))


  (add-hook 'c++-mode-hook
            (lambda ()
              (setq indent-tabs-mode t))))

(provide 'init-cc)
