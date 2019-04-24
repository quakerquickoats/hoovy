(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :monsterpiece
  :description "Monsterpiece"
  :author "Lyndon Tremblay <humasect@me.com>"
  :license "Specify license here"
  :version "0.1.0"
  :depends-on (:sdl2 :cl-opengl)
  :serial t
  :components ((:cl-file "package")
			   ;; core
			   (:cl-file "system")
			   (:cl-file "huma-math")
			   (:cl-file "engine")
			   (:cl-file "render")
			   (:cl-file "part")
			   (:cl-file "play")
			   (:cl-file "zone")
			   (:cl-file "monsterpiece")
			   ))


