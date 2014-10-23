;; init-fish.el - Setup emacs for editing fish scripts.

(req-package fish-mode

  ;; Better font lock keywords for fish
  :config (defconst fish-font-lock-keywords-1
            (list
             '("\\<\\(a\\(?:lias\\|nd\\)\\|b\\(?:egin\\|g\\|ind\\|lock\\|reak\\(?:point\\)?\\|uiltin\\)\\|c\\(?:ase\\|d\\|o\\(?:m\\(?:mand\\(?:line\\)?\\|plete\\)\\|nt\\(?:ains\\|inue\\)\\|unt\\)\\)\\|d\
ir[hs]\\|e\\(?:cho\\|lse\\|mit\\|nd\\|val\\|x\\(?:ec\\|it\\)\\)\\|f\\(?:g\\|ish\\(?:_\\(?:config\\|indent\\|p\\(?:ager\\|rompt\\)\\|right_prompt\\|update_completions\\)\\|d\\)?\\|or\\|\
unc\\(?:ed\\|save\\|tions?\\)\\)\\|h\\(?:elp\\|istory\\)\\|i\\(?:f\\|satty\\)\\|jobs\\|m\\(?:ath\\|imedb\\)\\|n\\(?:extd\\|ot\\)\\|o\\(?:pen\\|r\\)\\|p\\(?:opd\\|revd\\|sub\\|\\(?:ush\\
\|w\\)d\\)\\|r\\(?:andom\\|e\\(?:ad\\|turn\\)\\)\\|s\\(?:et\\(?:_color\\)?\\|ource\\|tatus\\|witch\\)\\|t\\(?:est\\|rap\\|ype\\)\\|u\\(?:limit\\|mask\\)\\|vared\\|while\\)\\_>"
               . font-lock-builtin-face)
             '("\\$\\([[:alpha:]_][[:alnum:]_]*\\)" . font-lock-variable-name-face))))

(provide 'init-fish)
