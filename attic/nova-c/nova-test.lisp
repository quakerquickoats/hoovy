(asdf:load-system :cffi)
;(asdf:load-system :swank)
;....for repl, (cffi:reload-foreign-libraries)

(defpackage :nova
  (:use :common-lisp :cffi :cl-opengl)
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
(defcfun "NV_EndFrame" :void)

;;(mapc #'export '(:nv-init :nv-shutdown :nv-error))
;;
;; (let ((pack (find-package :foo)))
;;   (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack) (export sym))))

;;;;;;;;;;;;;;;;;;;;;;
;; Execution
;;;;;;;;;;;;;;;;;;;;;;

(defvar *running* nil)

(defgeneric render-frame (state))

(defun main-loop (state)
  (when (and *running* state)
	(if (nv-update)
		(progn
		  (swank::handle-requests swank::*emacs-connection* t)

		  (gl:clear :color-buffer :depth-buffer)
		  (gl:matrix-mode :projection)
		  (gl:load-identity)

		  (gl:ortho 16 -16 16 -16 -1 1)
  
		  ;;(glu:perspective 50 (/ width height) 0.5 20)
		  (gl:matrix-mode :modelview)
		  (gl:load-identity)

		  (gl:flush)

		  (render-frame state)
		  (nv-endframe)
		  (main-loop state)))))

;;;;;;;;;;;;;;;;;;;;;
;; Boot
;;;;;;;;;;;;;;

(defvar *state* nil)

(defclass monsterpiece ()
  ((score :initform 0)))

(defmethod render-frame ((mp monsterpiece))
  (gl:color 1 0 0)
  (gl:with-primitives :lines
	(gl:vertex -16 -16)
	(gl:vertex 16 16)
	)
  
  (princ "heheheheh,")
  
  ;(gl:translate 0 0 -5)
  ;(gl:rotate 30 1 1 0)
  ;(gl:light :light0 :position '(0 1 1 0))
  ;(gl:light :light0 :diffuse '(0.2 0.4 0.6 0))
  ;(gl:clear :color-buffer :depth-buffer)
  ;(gl:color 1 1 1)
  ;(gl:front-face :cw)
  ;;(glut:solid-teapot 1.3)
  ;(gl:front-face :ccw)
  )

(defun run ()
  (nv-init 512 512)

  (gl:cull-face :back)
  (gl:depth-func :less)
  (gl:disable :dither)
  ;(gl:shade-model :smooth)
  ;(gl:light-model :light-model-local-viewer 1)
  ;(gl:color-material :front :ambient-and-diffuse)
  ;(gl:enable :light0 :lighting :cull-face :depth-test)
  
  (let ((*running* t)
		(*state* (make-instance 'monsterpiece)))
	(main-loop *state*)
	(nv-shutdown)))

