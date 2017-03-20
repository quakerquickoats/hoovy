;;
;; (c) 2017 Lyndon Tremblay
;;
;;

(defpackage wanderman (:use :cl))
(in-package :wanderman)

(defstruct wanderer
  level inventory equipment status shkel)

(defstruct world
  actors)

(defstruct actor)

(defun render (world)
  )
