;;; HUMAX
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(in-package :hoovy.humax)

;; OBJECT , SUBJECT , VERB

(defparameter *subjects*
  '(they he she we))

(defparameter *verbs*
  '(make take get find open eat drink play give break use sit push pull))

(defparameter *objects*
  '(book table door pencil cup fruit chair sandwich game floor wall))

(defparameter *place-verbs*
  '(walk go toward from))

;; in/on?  sit?

(defparameter *places*
  '(outside inside above below itself before behind))

(defparameter *manners*
  '(nicely gently carelessly wrecklessly))

(defun build-statement ()
  (mapcar (lambda (n) (random-word n)) (list *subjects* *verbs* *objects* *place-verbs* *places*)))

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
  '(box book chair table door shelf))

(defparameter *objects-male*
  '(pencil sword shoe nail lamp candle))

(defparameter *objects*
  (append *objects-female* *objects-male*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun random-element (seq)
  (elt seq (random (length seq))))

(defun make-object-name ()
  (list (random-element *adjectives*) (random-element *objects*)))

