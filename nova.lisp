;;
;; (c) 2017 Lyndon Tremblay
;;
;;

(defpackage :nova (:use :cl))
(in-package :nova)

(require :sdl2)
(require :cl-opengl)

(defun nova-init ()
  (gl:viewport 0 0 640 480)
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:clear-color 0.0 0.0 1.0 1.0)
  (gl:clear :color-buffer))

(defun handle-key (keysym)
  (let ((scancode (sdl2:scancode-value keysym))
	(sym (sdl2:sym-value keysym))
	(mod-value (sdl2:mod-value keysym)))
    (format t "Key: ~a - ~a - ~a~%" sym scancode mod-value)))

(defun nova-test ()
  (sdl2:with-init (:video)
    (sdl2:with-window (win :flags '(:shown :opengl))
      (sdl2:with-gl-context (gl-context win)
	(sdl2:gl-make-current win gl-context)
	(nova-init)
	(sdl2:with-event-loop (:method :poll)
	  (:keydown (:keysym keysym)
		    (handle-key keysym))
	  (:keyup (:keysym keysym))
	  (:idle ()
		 (gl:clear :color-buffer)
		 (gl:begin :triangles)
		 (gl:color 1.0 0.0 0.0)
		 (gl:vertex  0.0  1.0)
		 (gl:vertex -1.0 -1.0)
		 (gl:vertex  1.0  1.0)
		 (gl:end)
		 (gl:flush)
		 (sdl2:gl-swap-window win))
	  (:quit () t)
	  )))))
