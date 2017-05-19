(asdf:defsystem gamelike
  :description "Gamelike"
  :author "Lyndon Tremblay"
  :version "0.1.0"
  :depends-on (:cffi :cffi-grovel)
  :components
  ((:file "gamelike")
   ;;(:file "game-sdl")
   ;;(:file "window")
   (:file "namegen")
   (:file "char")
   (:file "world")
   (:file "wanderman")
   (:file "monster")
   ))

(defpackage :gamelike
  (:use :common-lisp)
  (:export :nothing-special))

(in-package :gamelike)

