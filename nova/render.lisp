;;;
;;; Nova
;;;
;;; (c) 2017 Lyndon Tremblay
;;;

(in-package :nova)

(defun renderPart (p)
  (mapc #'renderContents p))

(defun renderModel (s v a)
  (withResource s
		(lambda (r)
		  (gl:push-matrix)
		  (gl:translate v)
		  (gl:rotate a 0.0 0.0 1.0)
		  (mapc #'renderPart (slot-value r :parts)))))
