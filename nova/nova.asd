(defclass cl-file (cl-source-file)
  ((type :initform "cl")))

(asdf:defsystem :nova
  :description "Nova"
  :author "Lyndon Tremblay <huma.sect0@gmail.com>"
  :license "Unspecified"
  :version "0.1.0"
  :depends-on (:cl-raylib :cl-opengl)
  :serial t
  :components ( ;;; could use :cl-file here for ".cl" file extension.
               (:file "package")
               ;; core
               (:file "system")
               (:file "nova")
                ))
