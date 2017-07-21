(in-package :gamelike)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; all adjectives seem to be Dual. left right, up down, ...
;;
;; don't forget -- time vs. space
;; and -- mind vs. body,  in vs. out,  male vs. female
;;

(defparameter *adjectives-appearance*
  '(ugly pretty cute dirty clean))

(defparameter *adjectives-spacial*
  '(big small huge tiny empty full open closed))

(defparameter *adjectives-temporal*
  '(fast slow heavy light))

(defparameter *adjectives*
  (append *adjectives-appearance*
	  *adjectives-spacial*
	  *adjectives-temporal*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *objects-female*
  '(box book chair table))

(defparameter *objects-male*
  '(pencil sword shoe rabbit))

(defparameter *objects*
  (append *objects-female* *objects-male*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun random-word (seq)
  (elt seq (random (length seq))))

(defun make-object ()
  (list (random-word *adjectives*) (random-word *objects*)))

