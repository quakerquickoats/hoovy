(defpackage :hoovy.webserver
  (:use :cl :hunchentoot)
  (:export :start-server))

(in-package :hoovy.webserver)

(setq *dispatch-table*
      `(,(create-prefix-dispatcher "/hello-world" 'hello-page)))

(defun hello-page ()
  "<html><body>Welcome to Hoovy</body></html>")

(defvar *acceptor* nil)

(defun start-server (&key (port 4242))
  (stop-server)
  (start (setf *acceptor*
               (make-instance 'easy-acceptor
                              :port port
                              ;:document-root #p"/path/to/html/"
                              ))))

(defun stop-server ()
  (when *acceptor*
    (when (started-p *acceptor*)
      (stop *acceptor*))))
