;;(defpackage :hoovy-asd) ...
;;(in-package :cl-user)

(asdf:defsystem :humaweb
	:name "HumaWeb"
	:description "Hoovy Web"
	:version "0.1.0"
	:maintainer "Lyndon Tremblay <humasect@me.com>"
	:author "Lyndon Tremblay <humasect@icloud.com>"
	:license "Specify license here"
	;;  :defsystem-depends-on (:asdf-package-system)
	;;  :class :package-inferred-system
	:depends-on (:cl-who
				 :parenscript
				 :cl-css)
	:serial t
	:components ((:file "package")
				 (:file "humaweb")
				 (:file "map-js")
				 (:module "web")))


