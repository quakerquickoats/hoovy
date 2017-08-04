(in-package #:cl-user)

(asdf:defsystem #:hoovy
  :description "Describe hoovy here"
  :author "Lyndon Tremblay <humasect@icloud.com>"
  :license "Specify license here"
  :defsystem-depends-on (:radiance)
  :class "radiance:virtual-module"
  :depends-on (#:r-clip
               #:cl-who
               #:parenscript
               #:cl-css)
  :serial t
  :components ((:file "hoovy")))

(defpackage :hoovy
  (:use :common-lisp
	:radiance :cl-who :cl-css)
  (:export :nothing-special))

