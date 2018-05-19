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

(defcfun "NV_Init" :void)
(defcfun "NV_Shutdown" :void)
(defcfun "NV_Error" :void (fmt :string) &rest)

(let ((pack (find-package :foo)))
  (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack) (export sym))))

