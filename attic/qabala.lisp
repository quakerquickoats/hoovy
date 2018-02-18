(cl:defpackage :qabala
  (:use :common-lisp))
(in-package :qabala)

(defclass sefira ()
  (downface :initarg :downface :initform nil)
  (upface :initarg :upface :initform nil))

(defclass keter (sefira))

(defclass partzuf ())
