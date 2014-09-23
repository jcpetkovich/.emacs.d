;; magnars-defuns.el - Load magnars defuns

(defvar magnars-defuns-root (file-name-as-directory (file-name-directory (find-library-name 'magnars-defuns))))

(--each (--filter (s-equals? it "magnars-defuns.el"))
  (directory-files magnars-defuns-root nil ".*\\.el")
        (load it))

;; Possibly load eproject

(provide 'magnars-defuns)
