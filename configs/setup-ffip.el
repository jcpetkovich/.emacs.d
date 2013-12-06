
(require-package 'find-file-in-project)
(require 'find-file-in-project)

(setq ffip-limit 4096)

;;; Extra files to look for.
(--each '("*.tex" "*.bib" "*.markdown" "*.less" "*.css")
  (push it ffip-patterns))

(global-set-key (kbd "C-x C-o") 'find-file-in-project)

;; Use full project path for ffip
(defun ffip-project-files ()
  "Return an alist of all filenames in the project and their path."
  (let ((file-alist nil))
    (mapcar (lambda (file)
              (let ((file-cons (cons (s-chop-prefix (expand-file-name (ffip-project-root)) (expand-file-name file))
                                     (expand-file-name file))))
                (add-to-list 'file-alist file-cons)
                file-cons))
            (split-string (shell-command-to-string
                           (format "find %s -type f \\( %s \\) %s | head -n %s"
                                   (or ffip-project-root
                                       (ffip-project-root)
                                       (error "No project root found"))
                                   (ffip-join-patterns)
                                   ffip-find-options
                                   ffip-limit))))))

;; Helper methods to create local settings

(defun ffip--create-exclude-find-options (names)
  (mapconcat (lambda (name)
               (concat "-not -regex \".*" name ".*\"")) names " "))

(defun ffip-local-excludes (&rest names)
  "Given a set of names, will exclude results with those names in the path."
  (set (make-local-variable 'ffip-find-options)
       (ffip--create-exclude-find-options names)))

(defun ffip-local-patterns (&rest patterns)
  "An exhaustive list of file name patterns to look for."
  (set (make-local-variable 'ffip-patterns) patterns))

;; Function to create new functions that look for a specific pattern
(defun ffip-create-pattern-file-finder (&rest patterns)
  (lexical-let ((patterns patterns))
    (lambda ()
      (interactive)
      (let ((ffip-patterns patterns))
        (find-file-in-project)))))

;; Default excludes - override with ffip-local-excludes

(setq ffip-find-options
      (ffip--create-exclude-find-options
       '("node_modules"
         "target"
         "overlays"
         "build"
         "vendor")))

(provide 'setup-ffip)
