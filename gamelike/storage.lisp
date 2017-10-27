;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(in-package :gamelike)

(defclass storage ()
  ((%contents :initarg :contents :initform nil)
   (%capacity :initarg :capacity :initform 1)))
(defgeneric take-out (storage item))
(defgeneric put-in (storage item))

