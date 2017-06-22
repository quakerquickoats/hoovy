;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(in-package :gamelike)

(format t "Loading Gamelike.~%")


(defun generate-objects () '())
(defun generate-zones () '())

(defun generate-world ()
  (generate-zones)
  (generate-objects))

;; each actor has a world, each game has many actors
;; one game is a server

(defclass game ()
  ((%actors)))

(defun start-game ()
  (setq *actors* (load-actors)))
