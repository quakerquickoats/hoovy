;;
;; Nova
;; (c) 2020 Lyndon Tremblay
;;

(in-package :nova)

(defun nova-boot ()
  (format t "Initialize Nova...~%"))

(defun main-loop ()
  (with-window (640 480 "Nova")
    (set-window-position 100 100)  ;; does not work?? in exwm. C-c C-t C-f to unfloat/dock
    (set-target-fps 60)
    (loop
      (if (window-should-close) (return))
      (with-drawing
          (clear-background +raywhite+))
      (update-swank)))
  )

;;;;;;;;;;;;;;;;; helpers ;;;;;;;;;;;;;;;;;;;;;

;; from nikki93's github.com/nikki93/lgame/blob/master/game.lisp
;; this supposedly solves live editing problems for all the three main OS's
;; but on windows "single threaded mode" must be forced:
;; (setf *swank:*communication-style* nil) in ~/.swank.lisp

(defmacro --with-main (&body body)
  "Enables REPL access via UPDATE-SWANK in the main loop using SDL2.
   Wrap this around the sdl2:with-init code."
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
  "Helper macro that we can use to allow us to continue from an error.
   Remember to hit C in slime or pick the restart so errors don't kill the app."
  `(restart-case
       (progn ,@body) (continue () :report "Continue")))

(defun update-swank ()
  "Called from within the main loop, this keeps the lisp repl working while game engine runs"
  (continuable
   (let ((connection
	  (or swank::*emacs-connection*
	      (swank::default-connection))))
     (when connection
	   (swank::handle-requests connection t)))))
