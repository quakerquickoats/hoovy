(defpackage :alleg
  (:use :cl :cl-liballegro))
(in-package :alleg)

(defvar *display* nil)

(defun ready-set-go ()
  (al:init)
  (al:init-primitives-addon)
  (al:set-new-display-flags '(:windowed :resizable :opengl))
  (al:set-new-display-option :vsync 0 :require)
  (setf *display* (al:create-display 640 480))
  (al:clear-to-color (al:map-rgb 128 128 128))
  (al:draw-filled-rectangle
   100 110 400 450
   (al:map-rgb 255 255 255))
  (al:flip-display)
  (al:rest-time 2)
  (al:destroy-display *display*)
  (al:uninstall-system))

