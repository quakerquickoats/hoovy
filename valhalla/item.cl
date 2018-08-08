;;; Nova
;;;
;;; (c) 2017 Lyndon Tremblay
;;;

(in-package :nova.gamelike)

(defclass thing ()
  ((name :accessor thing-name
	 :initarg :name
	 :initform "no name")
   (desc :accessor thing-desc
	 :initarg :description
	 :initform "no description")))

(defclass item (thing)
  ((weight :accessor item-weight
	   :initarg :weight
	   :initform 0)
   (cost :accessor item-cost
	 :initarg :cost
	 :initform 0)
   ))

(defclass bag (item storage) ())

(defclass staff (item) ())
(defclass card (item) ())
(defclass equipment (item storage) ())
(defclass weapon (equipment) ())
(defclass armor (equipment) ())

;;;;;;;;;;;;;;;;;;;;;;;

(defclass weapon-basic-sword (weapon) ()
  )
