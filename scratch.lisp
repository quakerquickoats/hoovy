;; scratch forms.

;; 2016-09-26

;; ?? begin saving old scratch.

(defstruct world
  actors
  seed)

(defun go ()
  (ceramic:show (ceramic:make-window :url "https://www.h.com"
				     :width 320
				     :height 480)))
