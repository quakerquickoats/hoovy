;; scratch forms.

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
