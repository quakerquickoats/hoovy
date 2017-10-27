;;;; gamelike.asd

(asdf:defsystem :gamelike
  :description "Gamelike"
  :author "Lyndon Tremblay <humasect@icloud.com>"
  :license "Specify license here"
  :version "0.1.0"
;;  :class :package-inferred-system
  :defsystem-depends-on (:asdf-package-system)
;;  :depends-on (:gamelike/map)
  :serial t
  :components
  ((:file "package")
   (:file "qbl")
   (:file "actor")
   (:file "gamelike")
   (:file "item")
   (:file "zone")
   ;;(:file "game-sdl")
   ;;(:file "window")
   (:file "namegen")
   ;;(:file "char")
   (:file "world")
   (:file "monster")))


