(defpackage :hoovy.humax
  (:use :cl))

;; atom - aleph
;; eq - ayin
;; cons - waw
;; car - yod
;; cdr - hey
;; defun - ??

(in-package :hoovy.humax)

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
