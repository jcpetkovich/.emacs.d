(req-package web-mode
  :init
  (progn
    (--each '(("\\.html?\\'" . web-mode)
              ("\\.phtml\\'" . web-mode)
              ("\\.tpl\\.php\\'" . web-mode)
              ("\\.[gj]sp\\'" . web-mode)
              ("\\.as[cp]x\\'" . web-mode)
              ("\\.erb\\'" . web-mode)
              ("\\.mustache\\'" . web-mode)
              ("\\.djhtml\\'" . web-mode))
      (add-to-list 'auto-mode-alist it))))

(req-package less-css-mode)

(req-package jade-mode
  :mode ("\\.jade$" . jade-mode))

(req-package sws-mode
  :mode ("\\.styl$" . sws-mode))

(provide 'init-web)
