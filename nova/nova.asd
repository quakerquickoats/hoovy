(asdf:defsystem :nova
  :description "Nova"
  :author "Lyndon Tremblay <humasect@icloud.com>"
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
			   (:file "draw")
			   (:file "part")
			   (:file "play")
			   (:file "nova")

			   ;; game
			   (:file "actor")
			   (:file "char")
			   (:file "monster")
			   (:file "item")
			   (:file "storage")
			   (:file "world")
			   (:file "zone")

			   ;; client
			   (:file "pilot")
			   ))


