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
                 (:cl-file "parenscript-additions")
                 (:cl-file "web-output")
                 (:cl-file "web-display")
                 (:cl-file "web-actor")
                 
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
