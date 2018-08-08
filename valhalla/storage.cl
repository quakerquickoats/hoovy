;;; Valhalla
;;;
;;; (c) 2018 Lyndon Tremblay
;;;


(in-package :valhalla)

(defclass storage ()
  ((%contents :initarg :contents :initform nil)
   (%capacity :initarg :capacity :initform 1)))
(defgeneric take-out (storage item))
(defgeneric put-in (storage item))

