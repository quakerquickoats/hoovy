;;(in-package :cl-user)

(asdf:defsystem :hoovy
  :description "Describe hoovy here"
  :author "Lyndon Tremblay <humasect@icloud.com>"
  :license "Specify license here"
  :version "0.1.0"
  :defsystem-depends-on (:asdf-package-system)
;;  :class :package-inferred-system
  :depends-on (:cl-who
               :parenscript
               :cl-css)
  :serial t
  :components ((:file "package")
	       (:module "web")))


