;; -*- lexical-binding: t; -*- 

(require 'cl)

(cl-defstruct world
  actors
  map)

(defvar nova-process 2)

(defun nova-sentinel (p e)
  (message (format "Electron: '%s'" e)))

(defun nova-start ()
  "Start Nova."
  (make-process :name "electron"
		:buffer "*electron*"
		:command '("c:/electron/electron.exe")
		:sentinel 'nova-sentinel))

(defvar nova-routes
  '(("^.*//app/\\(.*\\)" . nova-app)
    ("^.*//wiki/\\(.*\\)" . elnode-wikipedia)
    ("^.*//\\(.*\\)" . elnode-webserver)))

(defun nova-handler (httpcon)
  (elnode-hostpath-dispatcher httpcon 'nova-routes)
  ;;(elnode-http-start httpcon 200 '("Content-Type" . "text/html"))
  ;;(elnode-http-return httpcon "<html><b>NovaEdit</b></html>")
  )

(elnode-start 'nova-handler
	      :port 9000
	      :host "localhost")
