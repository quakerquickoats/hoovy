;; Gamelike SDL2kit test.

(defpackage :gamelike
  (:use :cl :kit.sdl2))
(in-package :gamelike)

(defclass game-window (gl-window)
  ((starttime :initform (get-internal-real-time))
   (one-frame-time :initform (get-internal-real-time))
   (frames :initform 0)))

(defmethod initialize-instance :after ((w game-window) &key &allow-other-keys)
  (setf (idle-render w) t)
  (gl:viewport 0 0 640 480)
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity))


(defmethod render ((w game-window))
  (gl:load-identity)
  (gl:clear-color 0.0 0.0 0.0 1.0)
  (gl:clear :color-buffer)
  (gl:begin :triangles)
  (gl:vertex 0.0 0.5)
  (gl:vertex -0.5 -0.5)
  (gl:vertex 0.5 -0.5)
  (gl:end))

(defmethod close-window ((w game-window))
  (format t "Bye~%")
  (call-next-method))

;; (defmethod textinput-event ((w game-window) ts text)
;;   (format t "You typed: ~S~%" text))

(defmethod keyboard-event ((w game-window) state ts repeat-p keysym)
  (let ((scancode (sdl2:scancode keysym)))
    (when (eq :scancode-escape scancode)
      (close-window w))
    (unless repeat-p
      (format t "~A ~S ~S~%" state scancode (sdl2:scancode-name scancode)))))

