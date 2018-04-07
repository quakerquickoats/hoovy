(in-package :hoovy)

(defun ls ()
  (loop for s being the external-symbols of *package*
	 collect s)
  )
