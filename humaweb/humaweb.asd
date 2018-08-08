(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :humaweb
    :description "HumaWeb"
    :author "Lyndon Tremblay <humasect@me.com>"
    :license "Specify license here"
    :version "0.1.0"
    :depends-on (:cl-who :parenscript :css-lite)
    :encoding :utf-8
    :serial t
    :components ((:cl-file "package")

                 (:cl-file "huma-util")
                 (:cl-file "huma-math")
                 (:cl-file "parenscript-additions")
                 (:cl-file "output")
                 (:cl-file "display")
                 (:cl-file "geom")
                 (:cl-file "layer")
                 (:cl-file "anim")
                 (:cl-file "graph")
                 (:cl-file "actor")

			     ))
