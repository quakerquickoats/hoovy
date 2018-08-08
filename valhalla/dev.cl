;;;
;;; Nova
;;;
;;; (c) 2018 Lyndon Tremblay
;;;


(in-package :nova)

(defun lspkg (name)
  (do-external-symbols (s (find-package (string-upcase name)))
	(print s)))

