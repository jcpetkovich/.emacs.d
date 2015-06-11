;;; extensions.el --- rust-extras Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Jean-Christophe Petkovich & Contributors
;;
;; Author: Jean-Christophe Petkovich <jcpetkovich@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar rust-extras-pre-extensions
  '(
    ;; pre extension rust-extrass go here
    )
  "List of all extensions to load before the packages.")

(defvar rust-extras-post-extensions
  '(
    ;; post extension rust-extrass go here
    racer
    )
  "List of all extensions to load after the packages.")

;; Only load company-ess if company-mode is enabled
(when (configuration-layer/layer-usedp 'auto-completion)
  (defun rust-extras/post-init-company ()
    (spacemacs|enable-company rust-mode))

  (defun rust-extras/init-racer ()
    "Initialize racer if we're using company mode"
    (let* ((rust-layer-path (concat user/spacemacs-d-path "layers/rust-extras/"))
           (racer-path      (concat rust-layer-path "extensions/racer/"))
           (racer-elisp-dir (concat racer-path "editors/emacs/"))
           (racer-cmd-path  (concat racer-path "target/release/racer")))
      (if (file-exists-p racer-cmd-path)
          (use-package racer
            :defer t
            :init
            (progn
              (when rust-extras/lang-src-path
                (setq racer-rust-src-path (expand-file-name (concat rust-extras/lang-src-path "/src"))))
              (setq racer-cmd racer-cmd-path)
              (add-to-list 'load-path racer-elisp-dir)
              (eval-after-load "rust-mode" '(require 'racer))))
        (message "Warning: compile racer with cargo if you wish to use it with rust code.")))))

