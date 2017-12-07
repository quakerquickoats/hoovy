;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)

(require :sdl2)
(require :cl-opengl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defstruct Input
  (arrows '(nil nil nil nil))
  (charStates nil)
  (moveVector #(0 0 0))
  (buttons '(nil nil nil))
  (cursor '(nil nil nil))
  (screenCursor '(nil nil nil)))


(defvar noInput
  (make-input :arrows nil
			  :charStates nil
			  :moveVector nil
			  :buttons nil
			  :cursor nil
			  :screenCursor nil))

(defun setInputChar (i x b)
  nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass System ()
  ((lastTime :initform 0.0)
   (tickMul :initform 1.0)
   (window :initform nil)
   (renderer :initform nil)
   (game :initform nil))
  (:documentation "Platform-specific system calls"))

(defmethod initialize-instance :after ((sys System) &key)
  (sdl2:init :everything)
  (destructuring-bind (w r)
	  (sdl2:create-window-and-renderer 512 512 nil)
	(progn
	  (setf (slot-value sys 'window) w)
	  (setf (slot-value sys 'renderer) r))))

(defgeneric handleEvents (sys)
  (:documentation "Handle system events. Return T if we reached a form of conclusion to events."))

(defgeneric runEvents (sys)
  (:documentation "Run the event loop for all queued events."))

(defmethod runEvents ((sys System))
  (let* ((before (slot-value sys 'lastTime))
		 (now (get-internal-real-time))
		 (tick (- now before)))
	(unless (handleEvents sys)
	  (setf (slot-value sys 'lastTime) now)
	  (setf (slot-value sys 'game) (update (slot-value sys 'game) tick))
	  (runEvents sys))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass SDL-System (System) ())

(defmethod handleEvents ((sys SDL-System))
  (let ((stop nil)
		(e (sdl2:new-event)))
	;; (loop with stop = nil
	;; 	 do (when (sdl2:next-event e :poll nil))
	;; 	 until stop)
	(loop while (and (sdl2:next-event e :poll nil) (not stop))
	   do (setf stop (case (sdl2:get-event-type e)
					   (:keydown (print "asdoifjasodjf\n"))
					   (:quit nil))))
	(sdl2:free-event e)
	(not stop)))

(defun system-init-- ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "Novapilot" :flags '(shown))
      (sdl2:with-renderer (renderer win :flags '(:renderer-accelerated))
	(sdl2:with-event-loop (:method :poll)
	  (:keyup
	   (:keysym keysym)
	   (when (sdl2:scancode= (sdl2:scancode-value keysym)
				 :scancode-escape)
	     (sdl2:push-event :quit)))
	  (:idle
	   ()
	   )
	  (:quit () t))))))

(defun system-run (sys)
  (let* ((before (system-lastTime))
		 (now (get-internal-real-time))
		 (tick (- now before)))
	(when (system-handle-events sys)
	  (system-run sys..))))

(defun PlaySystem (class)
  (let ((s (make-instance class)))
	(runEvents s)))


;; (require :sdl2kit)
;; (defclass nova-window (kit.sdl2:gl-window)
;;   ((start-time :initform (get-internal-real-time))
;;    (tick-time :initform (get-internal-real-time))
;;    (frames :initform 0)))

;; (defmethod initialize-instance :after ((w nova-window) &key &allow-other-keys)
;;   ;; (setf (kit.sdl2:idle-render w) t)
;;   (gl:clear-color 0 0 1 1)
;;   (gl:clear :color-buffer-bit)
;;   (gl:viewport 0 0 512 512)
;;   (gl:matrix-mode :projection)
;;   (gl:ortho -1 1 -1 1 -1 1)
;;   (gl:matrix-mode :modelview)
;;   (gl:load-identity))

;; (defmethod render ((w nova-window))
;;   (format "rendere...\n")
;;   (gl:clear :color-buffer)
;;   (gl:begin :triangles)
;;   (gl:color 1.0 0.0 0.0)
;;   (gl:vertex  0.0  1.0)
;;   (gl:vertex -1.0 -1.0)
;;   (gl:vertex  1.0  1.0)
;;   (gl:end)
;;   ;(gl:flush)
;;   )

;; (defmethod close-window ((w nova-window))
;;   (format t "Exiting Nova.~%")
;;   (call-next-method))

;; (defmethod keyboard-event ((window nova-window) state ts repeat-p keysym)
;;   (format "asdasdads\n")
;;   (let ((scancode (sdl2:scancode keysym)))
;;     (when (eq :scancode-escape scancode)
;;       (close-window window))))
