(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :valhalla
    :description "Valhalla"
    :author "Lyndon Tremblay <humasect@me.com>"
    :license "Specify license here"
    :version "0.1.0"
    :depends-on (:cl-who :parenscript :css-lite)
    :encoding :utf-8
    :serial t
    :components ((:cl-file "package")

                 ;; general
                 (:cl-file "huma-util")
                 (:cl-file "huma-math")
                 
                 ;; web
                 (:module web
                          :components ((:cl-file "parenscript-additions")
                                       (:cl-file "output")
                                       (:cl-file "display")
                                       (:cl-file "geom")
                                       (:cl-file "layer")
                                       (:cl-file "anim")
                                       (:cl-file "graph")
                                       (:cl-file "actor")))
                 
			     ;; ;; core
			     ;; (:file "system")
			     ;; (:file "huma-math")
			     ;; (:file "engine")
			     ;; (:file "render")
			     ;; (:file "draw")
			     ;; (:file "part")
			     ;; (:file "play")
			     ;; (:file "nova")

			     ;; ;; game
			     ;; (:file "actor")
			     ;; (:file "char")
			     ;; (:file "monster")
			     ;; (:file "item")
			     ;; (:file "storage")
			     ;; (:file "world")
			     ;; (:file "zone")

			     ;; ;; client
			     ;; (:file "pilot")
			     ))
