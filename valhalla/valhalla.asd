(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :valhalla
    :description "Valhalla"
    :author "Lyndon Tremblay <humasect@me.com>"
    :license "Specify license here"
    :version "0.1.0"
    :depends-on (:hunchensocket)
    :encoding :utf-8
    :serial t
    :components ((:cl-file "package")

                 (:cl-file "world")
                 (:cl-file "char")
                 (:cl-file "actor")
                 (:cl-file "monster")
                 (:cl-file "namegen")
                 (:cl-file "item")
                 (:cl-file "storage")
                 (:cl-file "client")
                 
			     ))
