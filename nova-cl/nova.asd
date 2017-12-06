(asdf:defsystem :nova
  :description "Nova"
  :author "Lyndon Tremblay <humasect@icloud.com>"
  :license "Specify license here"
  :version "0.1.0"
  :depends-on (:sdl2 :cl-opengl)
  :serial t
  :components ((:file "package")
			   ;;(:file "nova")
			   (:file "system")
			   (:file "huma-math")
			   (:file "engine")
			   (:file "draw")
			   (:file "render")
			   (:file "nova")
			   ;;(:file "game-sdl")
			   ;;(:file "window")
			   (:file "novapilot")
			   ))


