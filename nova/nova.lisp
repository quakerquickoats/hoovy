(asdf:load-system :cffi)

(defpackage :nova
  (:use :common-lisp :cffi)
  ;;(:export :nv-init :nv-error)
  )
(in-package :nova)

(define-foreign-library nova
  (:unix (:default "./nova"))
  (t (:default "./nova")))

(use-foreign-library nova)

(defcfun "NV_Init" :void (width :int) (height :int))
(defcfun "NV_Shutdown"  :void)
(defcfun "NV_Error" :void (fmt :string) &rest)
(defcfun "NV_Update" :boolean)
(defcfun "NV_Render" :void)

;;(mapc #'export '(:nv-init :nv-shutdown :nv-error))


;;
;; (let ((pack (find-package :foo)))
;;   (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack) (export sym))))
