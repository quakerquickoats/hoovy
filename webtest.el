;; -*- lexical-binding: t; -*-

(require 'simple-httpd)
(require 'xmlgen)
(setq httpd-root "~/hoovy/wandering")
;;(httpd-start)

(defservlet wanderman text/html (path)
  (xmlgen '(html
	    (head
	     (title "wanderman")
	     ;;(meta :something "hi")
	     )
	    (body
	     (h1 "wander man")
	     (p "text.")))))

(require 'cl)

;; (cl-defstruct wm:actor
;;   level status inventory equipment shkel)
;; (cl-defstruct wm:state
;;   wanderer actors map story)

