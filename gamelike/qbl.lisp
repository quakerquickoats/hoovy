;; Gamelike
;;
;; (c) 2017 Lyndon Tremblay
;;

(in-package :gamelike)

(defparameter letters
  '((aleph ALF ox)
    (bet   BYT house)
    (gimel GML camel)
    (dalet DLT door)
    (heh   HEH life-breath)
    (waw   WAW nail)
    (zayin ZYN sword)
    (xet   XET fence)
    (tet   TET undefined-snake?)
    (yod   YOD hand)
    (kaf   KAF cup)
    (lamed LMD chain)
    (mem   MEM water)
    (nun   NUN undefined)
    (samek SMK undefined)
    (ayin  AYN eye)
    (peh   PEH mouth)
    (chadi CHD undefined-righteous)
    (qof   QOF monkey)
    (resh  RES head)
    (shin  SIN tooth)
    (taw   TAW mark-cross)))

(defun random-letter ()
  (elt letters (random 22)))

(defclass letter ()
  ((value :initform 0 :reader :value :allocation :class)))

(defclass aleph (letter)
  ((value :initform 1)))
(defclass )
