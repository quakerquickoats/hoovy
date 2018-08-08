(in-package :valhalla)

;(defvar *act-move-amt* 1)    ;; 32

(define-psmacros actor
  (make (name char x y)
        `(layer-make :name ,name
                     :bounds (rect-make ,x ,y 1 1)
                     :contents ,char
                     :fill-style "yellow")))

(define-jsoutput actor
  (defun actor-move (a angle)
    (let* ((by (point-rotate (point-make 0 -1) (deg-to-rad angle)))
           (to (point-add (layer-origin a) (point-snap by 1))))
      ;;(setprop a bounds (rect-make (.x up) (.y up) 1 1))
      (setf (layer-origin a) (keep-point-in-rect to (@ *screen* bounds)))
      ))

  )


