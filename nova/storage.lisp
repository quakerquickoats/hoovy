;;; Nova
;;;
;;; (c) 2017 Lyndon Tremblay
;;;


(in-package :nova.gamelike)

(defclass storage ()
  ((%contents :initarg :contents :initform nil)
   (%capacity :initarg :capacity :initform 1)))
(defgeneric take-out (storage item))
(defgeneric put-in (storage item))

