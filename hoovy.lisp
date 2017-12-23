(in-package :hoovy)

(defvar *layer-scale*)
(defvar *screen-width*)
(defvar *screen-height*)


(defun output-file (dir name ext fun)
  (let* ((fname (concat dir "/" name "." ext))
         (stream (open fname :direction :output :if-exists :supersede)))
    (format t "humaweb writing ~s...~%" fname)
    ;;(setf *parenscript-stream* nil)     ; unset this before each file,
                                        ; set below in define-jsoutput
    (funcall fun stream)
    (close stream)))

(defmacro fun-symbol (name ext)
  `(intern (concat (string-upcase (string ,name)) "-" (string-upcase ,ext))))

(defmacro do-output (dir kind lst)
  `(dolist (i ,lst)
     (let* ((fun (fdefinition (fun-symbol i ,kind))))
       (output-file ,dir i ,kind fun))))

(defparameter *builtin-js-names* '("geom" "layer" "anim" "graph"))

(defun output-project (&key (dir ".")
                       (html '()) (js '()) (css '())
                       (scale 1) (width 640) (height 480))
  (setf *screen-width* width)
  (setf *screen-height* height)
  (setf *layer-scale* scale)

  (do-output dir "js" (concatenate 'list js *builtin-js-names*))
  (do-output dir "html" html)
  (do-output dir "css" css))

;;
;; api for js, html, css
;;

;; (defmacro define-outputter (name ext &body body)
;;   `(defun ,(fun-symbol name ext) (stream) ,@body))

(defmacro define-jsoutput (name &body body)
  `(defun ,(fun-symbol name "js") (stream) ;define-outputter ,name "js"
     ;;(setf *parenscript-stream* stream)
     (ps-to-stream stream ,@body)))

(defmacro define-htmloutput (name &key
                             (title "humaweb application")
                             (scripts '())
                             (styles '())
                             (body nil))
  `(defun ,(fun-symbol name "html") (stream)
     (with-html-output (stream nil :indent t)
       (:html ;; :manifest "cache.manifest"
        (:head (:title ,title)
               (mapcar (lambda (s)
                         (htm
                          (:link :rel "stylesheet"
                                 :type "text/css"
                                 :href (concat s ".css"))))
                       ,styles)

               (mapcar (lambda (s)
                         (htm (:script :src (concat s ".js"))))
                       (concatenate 'list
                                    (list "jquery-1.4.2.min"
                                          ;;"functional.min"
                                          "underscore-1.1.0.min")
                                    *builtin-js-names*
                                    ,scripts)))
        (:body ,body)
        ))))

(defmacro define-cssoutput (name &body body)
  `(defun ,(fun-symbol name "css") (stream)
     (write (css-lite:css ,@body) :stream stream :escape nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass chat-room (hunchensocket:websocket-resource)
  ((name :initarg :name :initform (error "Name this room!") :reader name))
  (:default-initargs :client-class 'user))

(defclass user (hunchensocket:websocket-client)
  ((name :initarg :user-agent :reader name :initform (error "Name this user!"))))

(defvar *chat-rooms* (list (make-instance 'chat-room :name "/bongo")
						   (make-instance 'chat-room :name "/fury")))

(defun find-room (request)
  (find (hunchentoot:script-name request) *chat-rooms* :test #'string= :key #'name))

(pushnew 'find-room hunchensocket:*websocket-dispatch-table*)

(defun broadcast (room message &rest args)
  (loop for peer in (hunchensocket:clients room)
	 do (hunchensocket:send-text-message peer (apply #'format nil message args))))

(defmethod hunchensocket:client-connected ((room chat-room) user)
  (broadcast room "~a has joined ~a" (name user) (name room)))

(defmethod hunchensocket:client-disconnected ((room chat-room) user)
  (broadcast room "~a has left ~a" (name user) (name room)))

(defmethod hunchensocket:text-message-received ((room chat-room) user message)
  (broadcast room "~a says ~a" (name user) message))

(defvar *server* (make-instance 'hunchensocket:websocket-acceptor :port 12345))
(hunchentoot:start *server*)
