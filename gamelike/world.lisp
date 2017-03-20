(defpackage :gamelike
  (:use :common-lisp)
  (:export :nothing-special))
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

;; (defun make-object ()
;;   (list (random-word *adjectives*) (random-word *objects*)))

(defstruct object
  (adjective (random-word *adjectives*))
  (name (random-word *objects*)))

;;
;; STATUS
;;

(defstruct (status
	     ;; fix this constructor thing. simplify with the below slot init.
	     (:constructor make-status (&key level
				 (hp (max-stat-for-level 'hp level))
				 (sp (max-stat-for-level 'sp level))
				 (xp (max-stat-for-level 'xp level)))))
  (level 1)
  (hp (max-stat-for-level 'hp 1))
  (sp (max-stat-for-level 'sp 1))
  (xp 0))

(defun max-stat-for-level (stat level)
  (case stat
    ('hp (+ 100 (* level 22)))
    ('sp (* level 10))
    ('xp (expt level 4))))

(defun level-up (status)
  )

;;
;; ACTOR
;;

(defparameter *personalities*
  '(angry deoressed sketchy aloof asleep frantic hostile calm flaming))

(defparameter *statuses*
  '(normal confused fast slow stunned asleep beserk))

(defstruct actor
  (status nil)
  (x 0)
  (y 0)
  (map nil)
  (items nil)
  (equip nil))

;(defstruct wanderman (:include actor))

;;
;; WORLD
;;



(defparameter *land*
  '(field desert mountain forest temple cave city))

;; (deftype tile (&optional n)
;;   `'(floor (damage . ,n) water wall stairs (exit . n) (warp . n) pit))

(defparameter *tiles*
  '(floor damage water wall stairs exit warp pit))

(defparameter *shops*
  '(armor weapon medicine material fabric service tool))

(defstruct world
  (seed (random 1000))
  (actors nil))

(defun world-turn (world)
  world)

(defun world-display (world)
  "")

(defun world-input (world key))
