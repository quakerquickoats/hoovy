(defpackage :hoovy.chatserver
  (:use :cl :cl-irc))

(in-package :hoovy.chatserver)

(defvar *conn* nil)

(defun start-server ()
  (connect :nickname "hoovychat"
           :server "irc.freenode.net"))


;; (read-message-loop *conn*)

(defun stop-server ()
  nothing)

