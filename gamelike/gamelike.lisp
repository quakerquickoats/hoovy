;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(defpackage :gamelike
  (:use :common-lisp))

(in-package :gamelike)

(format t "Loading Gamelike.~%")

;; each actor has a world, each game has many actors
;; one game is a server

(defun make-player ()
  (make-instance 'actor ))
