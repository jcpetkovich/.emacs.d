
;; (require 'folding)

;; ;; ============================================================= 
;; ;; Hooks
;; ;; ============================================================= 
;; (folding-mode-add-find-file-hook)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; ;; ============================================================= 
;; ;; Folding mode - Conf files
;; ;; ============================================================= 
;; (folding-add-to-marks-list 'conf-space-mode "# {{{" "# }}}" nil t)
;; (folding-add-to-marks-list 'conf-mode "# {{{" "# }}}" nil t)
;; (folding-add-to-marks-list 'shell-script-mode "# {{{" "# }}}" nil t)

;; ;; ============================================================= 
;; ;; Haskell
;; ;; =============================================================
;; (folding-add-to-marks-list 'haskell-mode "-- {{{" "-- }}}" nil t)

;; ;; ============================================================= 
;; ;; Lua
;; ;; =============================================================
;; (folding-add-to-marks-list 'lua-mode "-- {{{" "-- }}}" nil t)
