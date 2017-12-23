;;; -*- lexical-binding: t; -*-
;;;
;;; start-elnode.el
;;;

(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(package-refresh-contents)
(package-install 'elnode)

(defun handler (httpcon)
  "Demonstration function"
  (elnode-http-start httpcon "200"
                     '("Content-type" . "text/html")
                     `("Server" . ,(concat "GNU Emacs " emacs-version)))
  (elnode-http-return httpcon "<html><body><h1>Hello from Emacs!</h1></body></html>"))

(elnode-start 
    'handler 
    :port (string-to-number (or (getenv "PORT") "8080")) 
    :host "0.0.0.0")

(while t (accept-process-output nil 1))
