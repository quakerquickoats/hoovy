;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(in-package :gamelike)

(defclass actor ()
  ((x :accessor actor-x
      :initarg :x
      :initform 0)
   (y :accessor actor-y
      :initarg :y
      :initform 0)))

(defclass monster (actor) ())
(defclass player (actor) ())

;;
;; ROOMS - inside buildings
;;
;; (defstruct room
;;   actors
;;   blocks
;;   environment 'plain)

(defclass zone ()
  ((%blocks :initarg :blocks)
   (%actors :initarg :actors :initform ())
   (%environment :initform plain)))

;; (defmethod initialize-instance :after ((map-room m))
;;   (format t "adfasdfas~%"))
