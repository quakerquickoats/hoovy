;;; Gamelike
;;;
;;; (c) 2017 Lyndon Tremblay
;;;

(in-package :nova.gamelike)

;;
;; JOB
;;

; sword, aco, mage, archer, theif, merchant

(defparameter *disposition*
  '(wanderer
    volunteer
    scribe
    soldier
    hunter
    artisan))

(defparameter *jobs*
  '(chef
    monk
    sage
    fighter
    archer
    craftsman))

(defparameter *second-jobs*
  '(alchemist
    priest
    wizard
    samurai    ; swordsman
    shaman     ; woodsman
    blacksmith))

(defparameter *job-stats-chef*
  '(10 5 1 10 5 1))

(defparameter *personalities*
  '(angry depressed sketchy aloof asleep frantic hostile calm flaming))

(defparameter *statuses*
  '(normal confused fast slow stunned asleep beserk))

;;
;; STATUS
;;

(defparameter *char-stats*
  '(STR AGI LUK INT VIT DEX))

;; fix this constructor thing. simplify with the below slot init.
(defstruct (char-status
	     (:constructor
	      make-char-status
	      (&key level
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





