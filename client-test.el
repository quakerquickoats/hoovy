;; -*- lexical-binding: t; -*-
;;
;;
;; (C) 2017 Lyndon Tremblay
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; network
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'websocket)
(defconst *nov-hostname* "localhost")
(defconst *nov-port* 9999)

(defvar *nv-socket* nil)
(defun nv-init-net (user pass)
  (interactive "sUsername: \nsPassword: ")
  (nv-log "Connecting...")
  (setq *nv-socket*
	(websocket-open
	 "ws://127.0.0.1:9999"
	 :on-message (lambda (_ws frame)
		       (message "ws frame: %S"
				(websocket-frame-text frame)))
	 :on-close (lambda (_ws) (setq *nv-closed* t))))
  (assert *nv-socket*)
  (nv-send `(:client (:login [,user ,pass]))))

(defun nv-send (text)
  (websocket-send-text *nv-socket*
		       (if (stringp text) text (print text))))

(defun nv-shutdown-net ()
  (setq *nv-socket* (websocket-close *nv-socket*)))

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
;; Game
;;;;;;;;;;;;;;;;;;;;;;;

(defgroup nova nil
  "Nova is a game."
  :tag "Nov"
  :group 'games)

(defcustom nv-buffer-name "*Nova*"
  "Name of the buffer for the game."
  :group 'nova
  :type '(string))

(defcustom nv-player-name "person"
  "Default name for the player."
  :group 'nova
  :type '(string))

(defconst nv-width 64)
(defconst nv-height 64)

;; (cl-defstruct wm:actor
;;   level status inventory equipment shkel)
;; (cl-defstruct wm:state
;;   wanderer actors map story)

;;;;;;;;;;;;;;;;

(defun nv-game-buffer () (get-buffer-create nv-buffer-name))
(defun nv-message-buffer () (get-buffer-create "*nv-messages*"))

(defun nv-log (msg)
  (with-current-buffer (nv-message-buffer)
    (set-window-point (get-buffer-window (nv-message-buffer))
		      (point-max))
    (goto-char (point-max))
    (insert msg)))

;;;;;;;;;;;;;;;

(defun --nv-init-display ()
  (setq f (make-frame
	   '((title . "WanderMan")
	     (name . "nv-frame")
	     (width . 80)
	     (height . 50)
	     (buffer-list .
			  '((nv-message-buffer) (nv-game-buffer)))
	     (unsplittable . t)
	     (menu-bar-lines . nil)
	     (tool-bar-lines . nil))))
  (select-frame f)
  (switch-to-buffer (nv-message-buffer))
  (setq w2 (split-window (selected-window) 10))
  (select-window w2)
  (switch-to-buffer (nv-game-buffer)))

(defun --nv-init-keys ()
  (set-buffer (nv-game-buffer))
  (local-set-key "q" 'nv-quit)

  (local-set-key "/" (lambda (cmd)
                       (interactive "sCommand: ")
                       (nv-send `(:command ,cmd))))

  (local-set-key "t" (lambda (msg)
                       (interactive "sMessage: ")
                       (nv-send `(:client (:say ,msg)))))

  (local-set-key "4" (lambda () (interactive) (lco-move 270)))
  (local-set-key "2" (lambda () (interactive) (lco-move 180)))
  (local-set-key "6" (lambda () (interactive) (lco-move 90)))
  (local-set-key "8" (lambda () (interactive) (lco-move 0)))

  (local-set-key "7" (lambda () (interactive) (lco-move 315)))
  (local-set-key "9" (lambda () (interactive) (lco-move 45)))
  (local-set-key "3" (lambda () (interactive) (lco-move 135)))
  (local-set-key "1" (lambda () (interactive) (lco-move 225))))

(defun nv-display-options ()
  "Computes display options, required by gamegrid for colors."
  (let ((options (make-vector 256 nil)))
	options))

(defvar nv-mode-map
  (let ((map (make-sparse-keymap 'nv-mode-map)))
	(define-key map [left] 'nv-move-left)
	(define-key map [right] 'nv-move-right)
	(define-key map [up] 'nv-move-up)
	(define-key map [down] 'nv-move-down)
	map)
  "Modemap for nova.")

(defun nv-init ()
  (get-buffer-create nv-buffer-name)
  (switch-to-buffer nv-buffer-name)
  (use-local-map nv-mode-map)

  ;;(nv-init-net)

  (setq gamegrid-use-glyphs t)
  (setq gamegrid-use-color t)
  (gamegrid-init (nv-display-options))
  (gamegrid-init-buffer nv-width nv-height ?\s))

(defun nv-quit ()
  (interactive)
  (nv-log "Quit.")
  (kill-buffer (nv-message-buffer))
  (kill-buffer (nv-game-buffer))
  ;;(nv-shutdown-net)
  )

;;;###autoload
(defun nov ()
  (interactive)
  (nv-init))

(provide 'nov)


