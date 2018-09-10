(require :cl-irc)
(defpackage :hoovy
     (:use :cl :cl-irc))
(in-package :hoovy)

(declaim (optimize (debug 3)))

(defclass hoovy ()
    ((connection :initarg :connection :initform nil)))

(defgeneric privmsg-hook (hoovy message))
(defgeneric privmsg (hoovy channel message))

(defmethod privmsg-hook ((h hoovy) message)
  (princ "-------")
  (princ message))

(defmethod privmsg ((h hoovy) chan message)
  (irc:privmsg (slot-value h 'connection) chan message))

(defun startup (name passwd)
  (let* ((con (irc:connect :nickname name
                           :server "irc.freenode.net"))
         (h (make-instance 'hoovy :connection con)))
    (privmsg h "NickServ" (concatenate 'string "identify " passwd))
    (irc:add-hook con 'irc-privmsg-message
                  'my-hook
                  ;;(lambda (msg) (privmsg-hook h msg))
                  )
    (irc:join con "#xelf")
    (irc:read-message-loop con)
    h))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-hook (message)
  (princ "------????------")
  (princ message))


