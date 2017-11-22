(in-package :nova)

(defparameter noVec '(0.0 0.0))


(defun translate-camera-pos (a b c x y)
  `'(,(/ (+ x (* a c)) c)
     ,(/ (+ y (* b c)) c)))

(defun angle-for-points (x0 y0 x1 y1)
  (atan2 (- y1 y0) (- x1 x0)))

(defun to-degrees (r)
  (* r (/ 180 pi)))

(defun keep-point-in-box (bx by x y)
  `'(,(if (< x 0)
	  (max x (- bx))
	  (min x bx))
     ,(if (< y 0)
	  (max y (- by))
	  (min y by))))

(defun is-point-in-square (x y w h bx by)
  (and (and (>= x bx) (<= x (+ bx w)))
       (and (>= y by) (<= y (+ by h)))))

;; (defun is-point-in-circle (a ar b br)
;;   (<= (magnitude-of (- b a))))

(defun distance-to-point-of-plane (cx cy x0 y0 x1 y1)
  (* (- cy y0) (- x1 x0)
     (- cx x0) (- y1 y0)))

