;;;
;;; Nova
;;;
;;; (c) 2017 Lyndon Tremblay
;;;

(in-package :nova)

;; PLATO specs. orange and black pixels
;;
;; xy char: 101 - 3264, line 1 char 1 - line 32 char 64
;; xy fine: 0,0 lower left - 511,511 top right

(defparameter display-width 512)
(defparameter display-height 512)
(defparameter char-width 8)
(defparameter char-height 16)
(defparameter char-set-1 nil) ;; builtin
(defparameter char-set-2 nil) ;; reserved
(defparameter char-set-3 nil) ;; user
(defparameter char-set-4 nil) ;; custom

;; draw, lift pen, etc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; SDL testing code

(defun nova-init ()
  (format t "Initialize Nova.~%")
  (finish-output)
  (gl:viewport 0 0 512 512)
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:clear-color 0.0 0.0 1.0 1.0)
  (gl:clear :color-buffer-bit))

(defun handle-key (keysym)
  (let ((scancode (sdl2:scancode-value keysym))
	(sym (sdl2:sym-value keysym))
	(mod-value (sdl2:mod-value keysym)))
    (format t "Key: ~a - ~a - ~a~%" sym scancode mod-value)
    (finish-output)))

(defvar *win* nil)
(defvar *gl-context* nil)

(defun nova-test ()
  (sdl2:init :everything)
  (setf *win* (sdl2:create-window-and-renderer 512 512 '(:shown :opengl)))
  ;;(sdl2:with-window (win :flags '(:shown :opengl)))
  (setf *gl-context* (sdl2:gl-create-context *win*))
  (sdl2:with-gl-context (*gl-context* *win*)
	(sdl2:gl-make-current *win* *gl-context*)
	(nova-init)
	(sdl2:with-event-loop (:background t)
	  (:keydown (:keysym keysym)
				(handle-key keysym))
	  (:keyup (:keysym keysym)
			  (when (sdl2:scancode= (sdl2:scancode-value keysym)
									:scancode-escape)
				(sdl2:push-event :quit)))
	  (:idle ()
			 (gl:clear :color-buffer)
			 (gl:begin :triangles)
			 (gl:color 1.0 0.0 0.0)
			 (gl:vertex  0.0  1.0)
			 (gl:vertex -1.0 -1.0)
			 (gl:vertex  1.0  1.0)
			 (gl:end)
			 (gl:flush)
			 (sdl2:gl-swap-window *win*))
	  (:quit () t)
	  )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass nova-window (kit.sdl2:gl-window)
  ((starttime :initform (get-internal-real-time))
   (one-frame-time :initform (get-internal-real-time))
   (frames :initform 0)))

(defmethod initialize-instance :after ((w nova-window) &key &allow-other-keys)
  (format t "Init window.~%")
   ;; with culling
  ;; (gl:enable :cull-face)
  ;; (gl:cull-face :back)
  ;; (gl:front-face :cw)
  (setf (kit.sdl2:idle-render w) t)
  (gl:viewport 0 0 512 512)
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity))


(defmethod render ((w nova-window))
  (format t "Renderrr ~%")
  (gl:clear-color 0 0 1 1)
  (gl:clear :color-buffer-bit)
  (gl:load-identity)
  (gl:begin :triangles)
  (gl:vertex 0 256)
  (gl:vertex 256 256)
  (gl:vertex 256 0)
  (gl:end))

(defmethod close-window ((w nova-window))
  (format t "Bye~%")
  ;; To _actually_ destroy the GL context and close the window,
  ;; CALL-NEXT-METHOD.  You _may_ not want to do this, if you wish to
  ;; prompt the user!
  (call-next-method))

(defmethod textinput-event :after ((window nova-window) ts text)
  (when (string= "Q" (string-upcase text))
	(close-window window)))

;; (defmethod textinput-event ((w game-window) ts text)
;;   (format t "You typed: ~S~%" text))

(defmethod keyboard-event ((w nova-window) state ts repeat-p keysym)
  (let ((scancode (sdl2:scancode keysym)))
    (when (eq :scancode-escape scancode)
      (close-window w))
    (unless repeat-p
      (format t "~A ~S ~S~%" state scancode (sdl2:scancode-name scancode)))))
