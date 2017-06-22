;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(in-package :gamelike)

;; islands!!

;;
;; THE CITY
;;
;; main area

;; (defstruct city
;;   (roads nil))

;;
;; THE DUNGEON
;;
;; underground sewers
;; mine shafts
;; caves

;; (deftype tile (&optional n)
;;   `'(floor (damage . ,n) water wall stairs (exit . n) (warp . n) pit))

(defparameter *map-tiles*
  '(floor damage water wall stairs exit warp pit))

;;
;; WORLD
;;


(defparameter *land*
  '(field desert mountain forest temple cave city))

(defparameter *shops*
  '(armor weapon medicine material fabric service tool))



(defclass world
  (seed (random 1000))
  (actors (generate-actors))
  (zones (generate-zones)))

(defmethod world-turn ((world))
  world)

(defun world-display (world)
  "")

(defun world-input (world key))
