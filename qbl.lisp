(defpackage :hoovy.qbl
  (:use :cl)
  (:export :otiyot))
(in-package :hoovy.qbl)

;;
;; some hebrew
;;

(defparameter otiyot
  '(Alf Bet Gml Dal Heh Waw Zay Xet Tet Yod
    Kaf Lam Mem Nun Sam Iyn Peh Tza Qof Rsh Sin Tau))

(defvar sephirot
  '(keter hokma bina
    hesed ))

;;
;; some english
;;

(defparameter alphabet "abcdefghijklmnopqrstuvwxyz")

(defun random-three ()
  (loop repeat 3 collect (nth (random (length alphabet)) alphabet)))
