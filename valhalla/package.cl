;;;; package.lisp

(defpackage :valhalla
  (:use :common-lisp :parenscript)
  (:documentation "valhalla game server"))

(defpackage :valhalla-web
  (:use :common-lisp :cl-who :parenscript :css-lite)
  (:documentation "valhalla web server"))

