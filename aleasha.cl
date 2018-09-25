<(require :cl-irc)
(defpackage :hoovy.aleasha
     (:use :cl :cl-irc))
(in-package :hoovy.aleasha)

(declaim (optimize (debug 3)))

;; we should just subclass irc-connection here, i think.

(defclass hoovy ()
  ((connection :initarg :connection :initform nil)))

(defgeneric private-message (hoovy message))

(defun create (name passwd)
  (let* ((con (irc:connect :nickname name
                           :server "irc.freenode.net"))
         (h (make-instance 'hoovy :connection con)))
    (irc:privmsg con "NickServ"
                 (concatenate 'string "identify " passwd))
    (irc:add-hook con 'irc-privmsg-message
                  (lambda (msg) (private-message h msg)))
    (irc:join con "#xelf")
    h))

(defun run (hoovy)
  (irc:read-message-loop (slot-value hoovy 'connection)))

(defmethod private-message ((h hoovy) message)
  (princ "------OKOK-----")
  (princ message))

;;(irc:privmsg (slot-value h 'connection) "#xelf" "hello yes i am")

