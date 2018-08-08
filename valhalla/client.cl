;;;
;;; Valhalla
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(in-package :valhalla)

;; (defun pause () nil)
;; (defun run () nil)

;; (defclass MainMenu (Nova:Scene)
;;   ((selected :initform 0)))

;; (defmethod start ((s MainMenu)))
;; (defmethod step ((s MainMenu) g))

;; (defclass Level (Nova:Scene))

;; (defmethod start ((m MainMenu)))

(defun make-player ()
  (make-instance 'actor ))

(defun init ()
  (format t "Loading Valhalla.~%")
  (setq world '())
  )

;;;;;;;;;

;; each actor has a world, each game has many actors
;; one game is a server

;; actor -> world -> game -> server
;;
;; or
;;
;; game(server) -> world[] -> actor[] ->

