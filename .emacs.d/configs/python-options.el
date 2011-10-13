;; ============================================================= 
;; Alternative Python mode (i like this one better)
;; ============================================================= 
(setq py-python-command "/usr/bin/python")
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")))

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(add-hook 'python-mode-hook 
          (lambda ()
            (local-set-key (kbd "M-<tab>") 'rope-code-assist)))

(defun ac-ropemacs-get-doc (symbol-name)
  (rope-get-doc))

(defun ac-ropemacs-candidates ()
  (mapcar (lambda (completion)
            (concat ac-prefix completion))
          (rope-completions)))

(ac-define-source nropemacs
  '((candidates . ac-ropemacs-candidates)
    (document . ac-ropemacs-get-doc)
    (symbol . "p")))

(ac-define-source nropemacs-dot
  '((candidates . ac-ropemacs-candidates)
    (document . ac-ropemacs-get-doc)
    (symbol . "p")
    (prefix . c-dot)
    (requires . 0)))

(defun ac-nropemacs-setup ()
  (interactive)
  (setq ac-sources (append '(ac-source-nropemacs
                             ac-source-nropemacs-dot) ac-sources)))

;; extended ropemacs

(defun ac-eropemacs-candidates ()
  (mapcar (lambda (proposal)
            (destructuring-bind (name doc type) proposal
              (list (concat ac-prefix name) doc
                    (if type (substring type 0 1) nil))))
          (rope-extended-completions)))

(defun ac-eropemacs-document (item) (car item))
(defun ac-eropemacs-symbol (item) (cadr item))

(ac-define-source extended-ropemacs
  '((candidates . ac-eropemacs-candidates)
    (document . ac-eropemacs-document)
    (symbol . ac-eropemacs-symbol)))

(ac-define-source extended-ropemacs-dot
  '((candidates . ac-eropemacs-candidates)
    (document . ac-eropemacs-document)
    (symbol . ac-eropemacs-symbol)
    (prefix . c-dot)
    (requires . 0)))

(defun ac-eropemacs-setup ()
  (setq ac-sources (append '(ac-source-extended-ropemacs
                             ac-source-extended-ropemacs-dot) ac-sources)))

(defun ac-ropemacs-setup ()
  (if (functionp 'rope-extended-completions)
      (add-hook 'python-mode-hook 'ac-eropemacs-setup)
    (add-hook 'python-mode-hook 'ac-nropemacs-setup)))

;;; IPython
(setq ipython-command "/usr/bin/ipython")
(require 'ipython)

(add-hook 'python-mode-hook (lambda () (ac-nropemacs-setup)))
