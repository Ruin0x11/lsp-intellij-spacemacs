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

(defun spacemacs//lsp-intellij-setup-leader-keys (mode)
  (spacemacs/set-leader-keys-for-major-mode mode
    ;; run
    "," 'lsp-intellij-run-at-point
    ;; configuration
    "cr" 'lsp-intellij-open-run-configurations
    ;; goto
    "gg" 'xref-find-definitions
    "gt" 'lsp-goto-type-definition
    "gi" 'lsp-goto-implementation
    "gr" 'xref-find-references
    ;; help/doc
    "hs" 'xref-find-apropos
    ;; project
    "pb" 'lsp-intellij-build-project
    "pr" 'lsp-intellij-run-project
    "ps" 'lsp-intellij-open-project-structure
    ;; refactor
    "rf" 'lsp-format-buffer
    ;; IDEA
    "It" 'lsp-intellij-toggle-frame-visibility))

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
