(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :humax
    :description "HUMAX"
    :author "Lyndon Tremblay <humasect@me.com>"
    :license "Specify license here"
    :version "0.1.0"
    :depends-on ()
    :encoding :utf-8
    :serial t
    :components ((:cl-file "package")

                 (:cl-file "humax")
                 (:cl-file "namegen")
                 
			     ))
