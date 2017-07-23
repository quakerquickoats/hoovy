;;;; hoovy.asd

(asdf:defsystem #:hoovy
  :description "Describe hv here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:hunchentoot
               #:cl-who
               #:parenscript
               #:cl-sdl2)
  :serial t
  :components ((:file "package")
               (:file "hoovy")))

