(in-package :gamelike)


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

(defun generate-actors () '())
(defun generate-zones () '())

(defstruct world
  (seed (random 1000))
  (actors (generate-actors))
  (zones (generate-zones)))

(defun world-turn (world)
  world)

(defun world-display (world)
  "")

(defun world-input (world key))
