;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)

(defun pause () nil)
(defun run () nil)

(defclass MainMenu (Nova:Scene)
  ((selected :initform 0)))

(defmethod start ((s MainMenu)))
(defmethod step ((s MainMenu) g))

(defclass Level (Nova:Scene))

(defmethod start ((m MainMenu)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun main ()
  (setq world '())

  (nova:init))
