;; scratch forms.

;; 2017-08-04

(defmethod draw ((ship s))
  (destructuring-bind (x y hp w h)
      (>> pushMatrix (translate x y 0))
    (if (< hp 0)
	(color3 1 1 1)
	(color3 0.33 0.33 0.33))
    (begin 'triangles)
    (vertex2 (- (/ w 2)) h)
    (vertex2 0 (- h))
    (vertex2 (/ w 2) h)
    (>> end popMatrix)))


;; 2017-06-11


;;2017-05-27

(defmacro matrix-macro ()
  (loop for i from 0 to 3 collect
       (let ((name (concatenate 'string "M0" (write-to-string i))))
	 `(,(intern name) 0.0 :type single-float))))


;; 2016-09-26

;; ?? begin saving old scratch.


(defun go ()
  (ceramic:show (ceramic:make-window :url "https://www.h.com"
				     :width 320
				     :height 480)))
