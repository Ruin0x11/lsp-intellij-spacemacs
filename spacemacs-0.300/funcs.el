;;; funcs.el --- lsp-intellij layer packages file for Spacemacs.
;;
;; Copyright (c) 2018 Richard Jones
;;
;; Author:  <richajn@amazon.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: MIT

;;; Code:

(defun spacemacs//lsp-intellij-setup-company ()
  (spacemacs|add-company-backends :backends company-lsp
                                  :modes java-mode kotlin-mode
                                  :variables company-lsp-enable-snippet t
                                  company-transformers nil
                                  company-lsp-async t
                                  company-idle-delay 0.5
                                  company-minimum-prefix-length 1
                                  company-lsp-cache-candidates t
                                  :hooks nil)
  (spacemacs//init-company-java-mode)
  (spacemacs//init-company-kotlin-mode)
  (company-mode))


;; The following is adapted from Spacemacs' Eclim completion functions:
;;  https://github.com/syl20bnr/spacemacs/blob/3731d0d/layers/%2Blang/java/funcs.el
(defun spacemacs//java-lsp-delete-horizontal-space ()
  (when (s-matches? (rx (+ (not space)))
                    (buffer-substring (line-beginning-position) (point)))
    (delete-horizontal-space t)))

(defun spacemacs/java-lsp-completing-dot ()
  "Insert a period and show company completions."
  (interactive "*")
  (spacemacs//java-lsp-delete-horizontal-space)
  (insert ".")
  (company-lsp 'interactive))

(defun spacemacs/java-lsp-completing-double-colon ()
  "Insert double colon and show company completions."
  (interactive "*")
  (spacemacs//java-lsp-delete-horizontal-space)
  (insert ":")
  (let ((curr (point)))
    (when (s-matches? (buffer-substring (- curr 2) (- curr 1)) ":")
      (company-lsp 'interactive))))

;;; funcs.el ends here
