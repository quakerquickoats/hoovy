;; -*- lexical-binding: t; -*-

(require 'simple-httpd)
(require 'xmlgen)
(setq httpd-root "~/hoovy/")
;;(httpd-start)

(defservlet hoovy-webtest text/html (path)
  (xmlgen '(html
	    (head
	     (title "hoovy-webtest")
	     ;;(meta :something "hi")
	     )
	    (body
	     (h1 "hoovy web test")
	     (p "text.")))))

(require 'cl)

;; (cl-defstruct wm:actor
;;   level status inventory equipment shkel)
;; (cl-defstruct wm:state
;;   wanderer actors map story)

(require 'websocket)
(eval-when-compile (require 'cl))

(defvar *hoovy-server* (websocket-server
			9999
			:host 'local
			:on-message #'hoovy-on-message
			:on-open #'hoovy-on-open))
