;;
;; Nova
;; (c) 2017 Lyndon Tremblay
;;
;;

(in-package :nova)



(defstruct Input
  (arrows '(nil nil nil nil))
  (charStates nil)
  (moveVector #(0 0 0))
  (buttons '(nil nil nil))
  (cursor '(nil nil nil))
  (screenCursor '(nil nil nil)))


(defvar noInput
  (make-input :arrows nil
			  :charStates nil
			  :moveVector nil
			  :buttons nil
			  :cursor nil
			  :screenCursor nil))

(defun setInputChar (i x b)
  nil)


(defclass Scene () ())
(defgeneric start ())
