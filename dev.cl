(defpackage :hoovy.dev
  (:use :cl)
  (:export :package-symbols))

(in-package :hoovy.dev)

(defun package-symbols (p)
  (loop for s being the external-symbols of (find-package p)
       collect s))

