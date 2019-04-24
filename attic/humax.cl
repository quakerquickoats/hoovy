;;; HUMAX
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(defpackage :hoovy.humax
  (:use :cl)
  (:export :random-element))

(in-package :hoovy.humax)

;;
;; System
;;

(defstruct CPU
  clock-speed
  instruction-set)

(defstruct System
  (cpu nil :type CPU)
  memory
  disk
  network
  graphics
  audio)

(defclass GPU ()
  ((dimensions :type Rectangle)))

;; (defclass APU ()
;;   (()))

(defparameter *power-table*
  `,)

(defun random-pow2 (n)
  (let ((pows (loop for i from 1 to n collect (expt 2 i))))
    (* 1024 (random-element pows))))

(defun gen-specs ()
  `(:clock-speed ,(random 1100)
    :memory ,(random-pow2 10)
    :colors ,(random 256)
    :disk ,(random-pow2 10)
    :audio-channels ,(+ 1 (random 8))))


;; #aaffcc

;;
;; Programming
;;

;; atom - aleph
;; eq - ayin
;; cons - waw
;; car - yod
;; cdr - hey
;; defun - ??

;;
;; Rendering
;;

(defclass Rectangle ()
  ((width :initarg :width)
   (height :initform 0 :initarg :height)))

(defclass Screen (Rectangle)
  ())

(defclass CellMap (Rectangle)  ;; 2d array
  ((cells :initform nil :initarg :cells)))

;;
;; Filesystem
;;

(defparameter FS-root
  '(/Carts/  ;; roms
    (/Dev/ framebuffer speakers gamepads)
    /Capture/  ;; png and gif and wav?
    ))

(defun list-dir (&optional dir)
  (princ FS-root))
