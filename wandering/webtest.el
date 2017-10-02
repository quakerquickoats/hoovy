;; -*- lexical-binding: t; -*-


(require 'simple-httpd)
(require 'esxml)

(setq httpd-root "~/hoovy/")
(httpd-start)

(defvar --es `(html (head (title "hoovy-webtest"))
		    (body (h1 "hello from emacs") (br)
			  (p "some text."))))

(defservlet hoovy-webtest text/html (path)
  (insert (sxml-to-xml --es)))

;;(require 'websocket)
;;(eval-when-compile (require 'cl))


