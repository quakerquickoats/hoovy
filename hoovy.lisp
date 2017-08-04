;;;; hoovy.lisp

(in-package :rad-user)
(define-module #:hoovy
    (:use #:cl #:radiance))

(in-package :hoovy)

(define-page example "/example" ()
  (setf (content-type *response*) "text/plain")
  "Hi!")
