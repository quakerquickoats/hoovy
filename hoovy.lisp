(defpackage :hoovy
  (:use :common-lisp)
  (:export :otiyot))
(in-package :hoovy)

;; don't forget -- time vs. space
;; and -- mind vs. body

(defparameter *descs*
  '(
    big
    small
    large
    heavy
    full
    open
    ugly
    fast
    slow
    ))

(defparameter *names*
  '(
    rabbit
    box
    hole
    truck
    book
    pencil
    chair
    ))

(defun random-word (seq)
  (elt seq (random (length seq))))

(defun make-object ()
  (list (random-word *descs*) (random-word *names*)))
