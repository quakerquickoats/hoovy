;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)

(defstruct Input
  (upArrow nil) (downArrow nil) (leftArrow nil) (rightArrow nil)
  (charStates nil)
  (moveVector noVec) ; multiple values
  (touch nil)
  (cursor noVec) (lastCursor noVec) (delta noVec))

(defstruct Game)

(defstruct Engine
  (lastCPUTime 0.0 :type float)
  (inputState (make-instance :Input))
  (game (make-instance 'game))
  (tickMul 1.0 :type float))

(defun modifyEngine (e f)
  (funcall f e))

(defmethod steppy ((e Engine))
  (let* ((now getElapsedTime)
	 (start (slot-value e :lastCPUTime))
	 (end (round now))
	 (tick (/ (- end start) 1000)))
    ;; ..stream..
    
    ))
