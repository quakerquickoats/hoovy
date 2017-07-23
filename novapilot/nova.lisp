;;
;; Novapilot
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :novapilot)

;;(require :sdl2)
;;(require :cl-opengl)


(defclass nova-window (kit.sdl2:gl-window)
  ((start-time :initform (get-internal-real-time))
   (tick-time :initform (get-internal-real-time))
   (frames :initform 0)))

(defmethod initialize-instance :after ((w nova-window) &key &allow-other-keys)
  (setf (kit.sdl2:idle-render w) t)
  (gl:clear-color 0 0 1 1)
  (gl:clear :color-buffer-bit)
  (gl:viewport 0 0 640 480)
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity))

(defmethod render ((w nova-window))
  (gl:clear :color-buffer)
  (gl:begin :triangles)
  (gl:color 1.0 0.0 0.0)
  (gl:vertex  0.0  1.0)
  (gl:vertex -1.0 -1.0)
  (gl:vertex  1.0  1.0)
  (gl:end)
  ;(gl:flush)
  )

(defmethod close-window ((w nova-window))
  (format t "Exiting Nova.~%")
  (call-next-method))

(defmethod keyboard-event ((window nova-window) state ts repeat-p keysym)
  (let ((scancode (sdl2:scancode keysym)))
    (when (eq :scancode-escape scancode)
      (close-window window))))
