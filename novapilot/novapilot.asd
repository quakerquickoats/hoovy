(asdf:defsystem novapilot
  :description "Novapilot"
  :author "Lyndon Tremblay"
  :version "0.1.0"
  :depends-on (:sdl2)
  :components
  ((:file "nova")
   ;;(:file "game-sdl")
   ;;(:file "window")
   ))

(defpackage :novapilot
  (:use :common-lisp)
  (:export :nothing-special))

(in-package :novapilot)

