;;;
;;; Monsterpiece
;;;
;;; (c) 2018 Lyndon Tremblay
;;;

(in-package :monsterpiece)

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

(defun handle-key (keysym)
  (let ((scancode (sdl2:scancode-value keysym))
	(sym (sdl2:sym-value keysym))
	(mod-value (sdl2:mod-value keysym)))
    (format t "Key: ~a - ~a - ~a~%" sym scancode mod-value)
    (finish-output)))

(defstruct Viewport
  (running nil)
  (width 0 :read-only t)
  (height 0 :read-only t)
  (window nil :read-only t)
  (gl-context nil :read-only t))

(defvar *viewport* nil)

(defun create-viewport (&optional (width 512) (height 512))
  (let* ((w (sdl2:create-window-and-renderer 512 512 '(:shown :opengl)))
		 (gl (sdl2:gl-create-context w)))
	(make-viewport :width width :height height
				   :window w :gl-context gl)))

(defun test1 ()
  (gl:begin :triangles)
  (gl:color 1 0 0)
  (gl:vertex  0.0  1.0)
  (gl:color 0 1 0)
  (gl:vertex -1.0 -1.0)
  (gl:color 0 0 1)
  (gl:vertex  1.0  1.0)
  (gl:end))

(defun test2 ()
  (gl:begin :triangles)
  (gl:color 1.0 0.0 0.0)
  (gl:vertex  0.0  1.0)
  (gl:vertex  1.0 -1.0)
  (gl:vertex -1.0  1.0)
  (gl:end))

(defvar *test* nil)

(defun viewport-render (v)
  (gl:viewport 0 0 (viewport-width v) (viewport-height v))
  (gl:matrix-mode :projection)
  (gl:ortho -1 1 -1 1 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:clear-color 0.0 0.0 1.0 1.0)
  (gl:clear :color-buffer-bit)

  (if *test*
	  (test1)
	  (test2))

  (format t "hmmm~%") (finish-output)
  (gl:flush)
  (sdl2:gl-swap-window (viewport-window v)))

(defvar *running* nil)

(defun viewport-idle (v)
  (format t "asdfasdfasdf~%")
  (sdl2:delay 1000)
  (when *running*
	;; do some nova stuff here, then render.
	(viewport-render v))
  (update-swank))

(defun nova-stop ()
  (setf *running* nil))

(defun nova-run ()
  (setf *running* t))

(defun nova-reset ()
  (sdl2:destroy-window (viewport-window *viewport*))
  (sdl2:gl-delete-context (viewport-gl-context *viewport*))
  (setf *viewport* nil))

(defvar *only-once* nil)

;; TODO: make an only-once macro

(defun nova-boot ()
  (when (not *viewport*)
	(format t "Initialize Nova...~%")
	(when (not *only-once*)
	  (sdl2:init :everything)
	  (setf *only-once* t))
	(setf *viewport* (create-viewport 512 512)))
  (sdl2:gl-make-current (viewport-window *viewport*) (viewport-gl-context *viewport*))
  (sdl2:with-event-loop (:method :poll) ;;(:background t)
	(:keydown (:keysym keysym)
			  (format t "flap jacks.~%") (finish-output)
			  (handle-key keysym))
	(:keyup (:keysym keysym)
			(format t "jjjjjjjjj~%") (finish-output)
			(when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
			  (sdl2:push-quit-event)))
	(:idle ()
		   (viewport-idle *viewport*))   ; gl-make-current here?
	(:quit () t)
	))


;; from nikki93's github.com/nikki93/lgame/blob/master/game.lisp
;; this supposedly solves live editing problems for all the three main OS's
;; but on windows "single threaded mode" must be forced:
;; (setf *swank:*communication-style* nil) in ~/.swank.lisp

(defmacro with-main (&body body)
  "Enables REPL access via UPDATE-SWANK in the main loop using SDL2. Wrap this around
the sdl2:with-init code."
  ;;TODO: understand this. Without this wrapping the sdl:with-init the sdl thread
  ;; is an "Anonymous thread" (tested using sb-thread:*current-thread*), while applying
  ;; this makes *current-thread* the same as the one one when queried directly from the
  ;; REPL thread: #<SB-THREAD:THREAD "repl-thread" RUNNING {adress...}>
  `(sdl2:make-this-thread-main
    (lambda ()
      ;; does work on linux+sbcl without the following line:
      #+sbcl (sb-int:with-float-traps-masked (:invalid) ,@body)
      #-sbcl ,@body)))


(defmacro continuable (&body body)
  "Helper macro that we can use to allow us to continue from an
  error. Remember to hit C in slime or pick the restart so errors don't kill the
  app."
  `(restart-case
       (progn ,@body) (continue () :report "Continue")))

(defun update-swank ()
  "Called from within the main loop, this keeps the lisp repl
working while cepl runs"
  (continuable
   (let ((connection
	  (or swank::*emacs-connection*
	      (swank::default-connection))))
     (when connection
	   (swank::handle-requests connection t)))))

