(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :qabala
  :description "Qabala"
  :author "Lyndon Tremblay <humasect@me.com>"
  :license "Specify license here"
  :version "0.1.0"
  :depends-on ()
  :serial t
  :components ((:cl-file "package")
			   (:cl-file "qabala")
			   ))


