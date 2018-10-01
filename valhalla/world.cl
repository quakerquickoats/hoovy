;;; Valhalla
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(in-package :valhalla)


;; planes
;; http://blogofholding.com/?p=3933

(defvar *planes* '(earth water fire wind spirit))

(defun plane-desc (p)
  (case p
    ('earth "Underground Caves and Dungeon")
    ('water "")))

;; islands!!

;;
;; THE CITY
;;
;; main area

;; (defstruct city
;;   (roads nil))

;;
;; THE DUNGEON
;;
;; underground sewers
;; mine shafts
;; caves

;; (deftype tile (&optional n)
;;   `'(floor (damage . ,n) water wall stairs (exit . n) (warp . n) pit))

(defparameter *map-tiles*
  '(floor damage water wall stairs exit warp pit))

;;
;; WORLD
;;


(defparameter *land*
  '(field desert mountain forest temple cave city))

(defparameter *shops*
  '(armor weapon medicine material fabric service tool))

;; world -> zones -> actors -> objects

(defclass Zone ()
  ((actors :initform (generate-actors))))

(defclass World ()
  ((seed :initform (random 1000))
   (actors :initform (generate-actors))
   (zones :initform (generate-zones))))

;;;;;;;;;;

(defun new-world ()
  '(:zones ()
    :actors ()
    :objects ()
    ))

(defvar *world* nil)

(defun generate-actors () nil)
(defun generate-items () nil)
(defun generate-zones ()
  (loop for i from 1 to (1+ (random 10))
     collect (concatenate 'string "Zone " (write-to-string i))))

(defun generate-world ()
  (let ((w (new-world)))
    `(:zones ,(generate-zones)
      :actors ,(generate-actors)
      :items ,(generate-items))))


(defgeneric update-world (s f))
(defmethod update-world ((s symbol) (f function))
  (setf (getf *world* s) (funcall f (getf *world* s))))
(defmethod update-world ((s symbol) v)
  (setf (getf *world* s) v))

(defun save-world ()
  (with-open-file (out "world.db"
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (print *world* out))))

(defun load-world ()
  (with-open-file (in "world.db")
    (with-standard-io-syntax
      (setf *world* (read in)))))

(defun turn-world ()
  )

(defun actor-named (n)
  (getf (getf *world* :actors) n))

