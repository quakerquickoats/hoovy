;; -*- lexical-binding: t -*-
;; boust.el --- A boustephedron reader for Emacs
;;
;; (c) 2018 Lyndon Tremblay
;;

(defun boust-find-file (filename)
  (interactive "FFilename: ")
  (print filename))


(define-minor-mode boust-mode
  "Toggle Boustephedron mode."
  :init-value nil
  :lighter " Boust"
  :group 'boust
  :keymap '(()))
