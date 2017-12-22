(defpackage :huma4drl-asd)
(in-package :huma4drl-asd)

(asdf:defsystem huma4drl
  :name "huma4drl"
  :version "1.0"
  :maintainer "humasect"
  :author "humasect"
  :description "humasect's 4-Day Roguelike"
  :serial t
  :depends-on (:cl-who :parenscript :humaweb)
  :components ((:file "huma4drl")
               (:file "actor-js")
               (:file "map-js")))
