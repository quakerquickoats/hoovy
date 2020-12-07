;;
;; Nova
;; (c) 2020 Lyndon Tremblay
;;

(in-package :nova)

;;;;;;;;;;;;;;;;; machine code ;;;;;;;;;;;;;;;;;;

(defun nova-run-code (c)
  c)

(defun example-code ()
  `((nova-boot)
    (main-loop)))

;;;;;;;;;;;;;;;;;;;;;;; 

(defparameter instructions
  '((memset ptr val)
    (memcpy dst src)
    (alloc numBytes)
    (free ptr)
    ()))

;; 1) reference counting
;; 2) 
