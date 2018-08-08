(cl:defpackage :qabala
  (:use :common-lisp))
(in-package :qabala)

(defclass sefira ()
  ((downface :initarg :downface :initform nil)
   (upface :initarg :upface :initform nil)))

(defclass long-face () ())

(defclass keter (sefira long-face) ())
(defclass hokma (sefira long-face) ())
(defclass binah (sefira long-face) ())

(defclass partzuf () ())

(defclass letter () ())
(defclass alef (letter) ())
(defclass beth (letter) ())
(defclass giml (letter) ())
(defclass dalt (letter) ())
(defclass heh (letter) ())



