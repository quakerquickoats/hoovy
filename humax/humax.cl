;;; HUMAX
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(defpackage :hoovy.humax
  (:use :cl))

(in-package :hoovy.humax)

;; atom - aleph
;; eq - ayin
;; cons - waw
;; car - yod
;; cdr - hey
;; defun - ??

(defparameter FS-root
  '(/Carts/  ;; roms
    (/Dev/ framebuffer speakers gamepads)
    /Capture/  ;; png and gif and wav?
    ))

(defclass Rectangle ()
  ((width :initarg :width)
   (height :initform 0 :initarg :height)))

(defclass Screen (Rectangle)
  ())

(defclass CellMap (Rectangle)  ;; 2d array
  ((cells :initform nil :initarg :cells)))

(defun list-dir (&optional dir)
  (princ FS-root))
