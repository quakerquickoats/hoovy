#;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)

(defconstant procedural
  '(Default
    Gradient CompassDirection
    (Textured string) (Model string) (image string)))

(defstruct Part
  (layer 0 :type integer)
  (flags "")
  (perf '())
  (travel noVec)
  (winding nil)
  (trans '()))

(defmethod isPartInside ((a Part) (error float) (b Part))
  (isWindingInside error a b))

;;;;;;;;;;;;;;;;;;;;;;

(defmethod render ((a Part))
  (mapc #'renderContents a))

(defun renderModel (s v a)
  (withResource s
		(lambda (r)
		  (gl:push-matrix)
		  (gl:translate v)
		  (gl:rotate a 0.0 0.0 1.0)
		  (mapc #'render (slot-value r :parts)))))

(defun renderProcedure (proc p)  ;; p is Part
  (when (isDepthProc proc)
    (gl:enable :depth-test)
    (gl:depth-func :always)
    (gl:depth-mask t)
    (gl:color-mask 0 0 0 0)
    (composeDrawing (procedure :Default p))
    (gl:depth-mask nil)
    (gl:color-mask 1 1 1 1)
    (gl:depth-func :gequal))

  (composeDrawing (procedure proc p))

  (when (isDepthProc proc)
    (gl:depth-mask t)
    (gl:clear :depth-buffer-bit)
    (gl:depth-mask nil)
    (gl:disable :depth-test)))
