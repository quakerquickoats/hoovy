;;; Gamelike
;;;
;;; (c) 2017 Lyndon Tremblay
;;;

(in-package :nova.gamelike)

(defclass actor-stats ()
  (earth water fire wind ether))

(defclass actor-def ()
    ((level :initform 1)
     (hp :initform 10)
     (sp :initform 1)
     (xp :initform 0)
     (stats :initform
	    '(:str 1 :agi 1 :luk 1 :vit 1 :int 1 :dex 1))))

;; s.p.e.c.i.a.l. attributes (seven ?)

;; (defclass slime-def (actor-def)
;;   ((hp 22)
;;    (sp 1)
;;    (xp 1)))

(defclass actor ()
  (tag
   (level :initform 1)
   (hp :initform 10)
   (sp :initform 1)
   (xp :initform 0)
   (stats :initform '(STR AGI LUK VIT INT DEX))
   inventory
   triggers))


