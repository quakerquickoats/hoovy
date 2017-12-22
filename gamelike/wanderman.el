;; -*- lexical-binding: t; -*-
;;
;; Gamelike
;;
;; (C) 2017 Lyndon Tremblay
;;


;; (cl-defstruct wm:actor
;;   level status inventory equipment shkel)
;; (cl-defstruct wm:state
;;   wanderer actors map story)

;;;;;;;;;;;;;;;;

(require 'websocket)

(defconst *wm-hostname* "localhost")
(defconst *wm-port* 9999)

(defun wm-game-buffer ()
  (get-buffer-create "*wm-game*"))
(defun wm-message-buffer ()
  (get-buffer-create "*wm-messages*"))

(defun wm-log (msg)
  (with-current-buffer (wm-message-buffer)
    (set-window-point (get-buffer-window (wm-message-buffer))
		      (point-max))
    (goto-char (point-max))
    (insert msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; network
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *wm-socket* nil)
(defun wm-init-net (user pass)
  (interactive "sUsername: \nsPassword: ")
  (wm-log "Connecting...")
  (setq *wm-socket*
	(websocket-open
	 "ws://127.0.0.1:9999"
	 :on-message (lambda (_ws frame)
		       (message "ws frame: %S"
				(websocket-frame-text frame)))
	 :on-close (lambda (_ws) (setq *wm-closed* t))))
  (assert *wm-socket*)
  (wm-send `(:client (:login [,user ,pass]))))

(defun wm-send (text)
  (websocket-send-text *wm-socket*
		       (if (stringp text) text (print text))))

;;;;;;;;;;;;;;;;;;;;;;;
;; regular net (old)
;;;;;;;;;;;;;;;;;;;;;;;

(defvar lco-process nil)

(defun lco-change-room (room)
  (lco-log (format "change room! %s" room))
  (with-current-buffer (lco-game-buffer)
    (erase-buffer)))


(defun lco-send (obj)
  (setq str (json-encode obj))
  (process-send-string lco-process str))

(defun lco-filter (proc string)
  (lco-log string)
  (let* ((msg (car (json-read-from-string string)))
         (name (car msg))
         (args (cdr msg)))
    (cond ((eq name 'change_room) (lco-change-room))
          (t (lco-log (format "json: %s\n" msg)))
          )))

(defun lco-sentinel (proc what)
  (lco-log what))

(defun lco-init-net (user pass)
  (lco-log "Connecting... ")
  (setq lco-process (make-network-process
                     :name "lco-client"
                     :type nil
                     :host lco-server
                     :service lco-port
                     :family nil
                     :buffer (lco-game-buffer)
                     :coding 'utf-8
                     :filter 'lco-filter
                     :sentinel 'lco-sentinel))
  (if lco-process
      (lco-log "OK.\n")
    (lco-log "Error.\n")))


;;;;;;;;;;;;;;;;;;;;;;;
;; API
;;;;;;;;;;;;;;;;;;;;;;;

(defun wm-init-display ()
  (setq f (make-frame
	   '((title . "WanderMan")
	     (name . "wm-frame")
	     (width . 80)
	     (height . 50)
	     (buffer-list .
			  '((wm-message-buffer) (wm-game-buffer)))
	     (unsplittable . t)
	     (menu-bar-lines . nil)
	     (tool-bar-lines . nil))))
  (select-frame f)
  (switch-to-buffer (wm-message-buffer))
  (setq w2 (split-window (selected-window) 10))
  (select-window w2)
  (switch-to-buffer (wm-game-buffer)))

(defun wm-init-keys ()
  (set-buffer (wm-game-buffer))
  (local-set-key "q" 'wm-quit)

  (local-set-key "/" (lambda (cmd)
                       (interactive "sCommand: ")
                       (lco-send `(:command ,cmd))))

  (local-set-key "t" (lambda (msg)
                       (interactive "sMessage: ")
                       (lco-send `(:client (:say ,msg)))))

  (local-set-key "4" (lambda () (interactive) (lco-move 270)))
  (local-set-key "2" (lambda () (interactive) (lco-move 180)))
  (local-set-key "6" (lambda () (interactive) (lco-move 90)))
  (local-set-key "8" (lambda () (interactive) (lco-move 0)))

  (local-set-key "7" (lambda () (interactive) (lco-move 315)))
  (local-set-key "9" (lambda () (interactive) (lco-move 45)))
  (local-set-key "3" (lambda () (interactive) (lco-move 135)))
  (local-set-key "1" (lambda () (interactive) (lco-move 225))))

(defun wm-init ()
  (wm-init-display)
  (wm-init-keys)
  (wm-init-net))

(defun wm-quit ()
  (interactive)
  (wm-log "Quit.")
  (setq *wm-socket* (websocket-close *wm-socket*)))
