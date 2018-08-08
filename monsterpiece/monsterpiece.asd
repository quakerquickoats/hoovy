(asdf:defsystem :monsterpiece
  :description "Monsterpiece"
  :author "Lyndon Tremblay <humasect@me.com>"
  :license "Specify license here"
  :version "0.1.0"
  :depends-on (:sdl2 :cl-opengl)
  :serial t
  :components ((:file "package")
			   ;; core
			   (:file "system")
			   (:file "huma-math")
			   (:file "engine")
			   (:file "render")
			   (:file "part")
			   (:file "play")
			   (:file "zone")
			   (:file "monsterpiece")
			   ))


