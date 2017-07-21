;; -*- lexical-binding: t; -*-
;;
;; https://github.com/johnmastro/trident-mode.el

(defmacro emacsript (&rest body)
  (let ((printed-forms (emacsript-print
			(compile-statement `(progn ,@body))
			nil)))
    (if (and (not (cdr printed-forms))
	     (stringp (car printed-forms)))
	(car printed-forms)
      (let ((s (gensym)))
	`(with-output-to-string
	   (,s)
	   ,@(mapcar (lambda (x) `(write-string ,x ,s))
		     printed-forms))))))

(defvar es-test1 '(defun foobar (a b)
		    (return (+ a b))))

