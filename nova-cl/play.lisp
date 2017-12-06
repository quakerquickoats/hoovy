;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)

(defstruct Model
  (windings))

(defclass Scene ())


(defclass Game ()
  ((scene :initform nil)))

(defgeneric update (game tick)
  (:documentation "Update game"))

(defmethod update ((g Game) tick)
  g)
