(in-package :gamelike)

;;
;; STATUS
;;

(defstruct (status
	     ;; fix this constructor thing. simplify with the below slot init.
	     (:constructor make-status (&key level
				 (hp (max-stat-for-level 'hp level))
				 (sp (max-stat-for-level 'sp level))
				 (xp (max-stat-for-level 'xp level)))))
  (level 1)
  (hp (max-stat-for-level 'hp 1))
  (sp (max-stat-for-level 'sp 1))
  (xp 0))

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
  '(angry deoressed sketchy aloof asleep frantic hostile calm flaming))

(defparameter *statuses*
  '(normal confused fast slow stunned asleep beserk))

(defstruct actor
  (status nil)
  (x 0)
  (y 0)
  (map nil)
  (items nil)
  (equip nil))



