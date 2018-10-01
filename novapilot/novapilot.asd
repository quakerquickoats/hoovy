(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :novapilot
  :description "Novapilot"
  :author "Lyndon Tremblay <humasect@me.com>"
  :license "Specify license here"
  :version "0.1.0"
  :depends-on (:cl-opengl)
  :serial t
  :components ((:cl-file "package")
               ;; core
			   ;;(:cl-file "huma-math")
			   ))


