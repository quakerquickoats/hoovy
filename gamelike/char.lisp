(in-package :gamelike)

;;
;; JOB
;;

; sword, aco, mage, archer, theif, merchant

(defconstant *disposition*
  '(wanderer
    volunteer
    scribe
    soldier
    hunter
    artisan))

(defconstant *jobs*
  '(chef
    monk
    sage
    fighter
    archer
    craftsman))

(defconstant *second-jobs*
  '(alchemist
    priest
    wizard
    samurai    ; swordsman
    shaman     ; woodsman
    blacksmith))

(defconstant *job-stats-chef*
  '(10 5 1 10 5 1))

;;
;; STATUS
;;

(defconstant *char-stats*
  '(STR AGI LUK INT VIT DEX))

(defstruct (char-status
	     ;; fix this constructor thing. simplify with the below slot init.
	     (:constructor make-char-status (&key level
				 (hp (max-stat-for-level 'hp level))
				 (sp (max-stat-for-level 'sp level))
				 (xp (max-stat-for-level 'xp level)))))
  (level 1)
  (hp (max-stat-for-level 'hp 1))
  (sp (max-stat-for-level 'sp 1))
  (xp 0)
  (mood 'normal)
  inventory
  equipment
  money)

(defun max-stat-for-level (stat level)
  (case stat
    ('hp (+ 100 (* level 22)))
    ('sp (* level 10))
    ('xp (expt level 4))))

(defun level-up (status)
  )

;;
;; ACTOR
;;

(defparameter *personalities*
  '(angry depressed sketchy aloof asleep frantic hostile calm flaming))

(defparameter *statuses*
  '(normal confused fast slow stunned asleep beserk))

(defclass storage ()
  ((%contents :initarg :contents :initform nil)
   (%capacity :initarg :capacity :initform 1)))
(defgeneric take-out (storage item))
(defgeneric put-in (storage item))

(defclass thing ()
  ((%name :initarg :name :initform "no name")
   (%desc :initarg :description :initform "no description")))

(defclass item (thing)
  ((%weight :initarg :weight :initform 0)
   (%cost :initarg :cost :initform 0)
   ))

(defclass bag (item storage) ())

(defclass staff (item) ())
(defclass card (item) ())
(defclass equipment (item storage) ())
(defclass weapon (equipment) ())
(defclass armor (equipment) ())

(defclass entity (thing)
  ((%x :initarg :x :initform 0)
   (%y :initarg :y :initform 0)))

(defclass actor (thing storage) ())
(defclass monster (actor) ())
(defclass player (actor) ())



