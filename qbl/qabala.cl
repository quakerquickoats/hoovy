(cl:defpackage :hoovy.qbl
  (:use :common-lisp))
(in-package :hoovy.qbl)

(defclass sefira ()
  ((downface :initarg :downface :initform nil)
   (upface :initarg :upface :initform nil)))

(defclass long-face () ())

(defclass keter (sefira long-face) ())
(defclass hokma (sefira long-face) ())
(defclass binah (sefira long-face) ())

(defclass chesed (sefira))
(defclass netzach (sefira))
(defclass din (sefira))
(defclass hod (sefira))

(defclass tiferet (sefira))
(defclass yesod (sefira))

(defclass partzuf () ())

;;
;;  letters
;;

(defclass letter () ())
(defclass final-letter () ())
(defclass mother-letter (letter) ())  ;; only 3
(defclass double-letter (letter) ())  ;; only 7
(defclass elemental-letter (letter) ())   ;; only 12

(defmacro defletter (l c &rest args)
  `(defclass ,l (,(intern (concatenate 'string (symbol-name c) "-LETTER"))) (,@args)))

;; (defmacro defletters (list)
;;   `,(mapcar #'defletter list))
;; (defletters )
;;
;; (defelementals...)

(defletter alef mother)
(defletter beth double)
(defletter giml double)
(defletter dalt elemental)
(defletter heh elemental)
(defletter waw elemental)
(defletter zayn elemental)
(defletter chet elemental)
(defletter tet elemental)
(defletter yod elemental)
(defletter khaf double)
(defletter lamd elemental)
(defletter mem mother)
(defletter nun elemental)
(defletter samk elemental)
(defletter ayin elemental)
(defletter peh double)
(defletter sadi elemental)
(defletter qof elemental)
(defletter resh double)
(defletter shin mother)
(defletter tau double)



