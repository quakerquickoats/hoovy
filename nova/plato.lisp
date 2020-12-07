;;
;; Nova
;; (c) 2020 Lyndon Tremblay
;;

(in-package :nova)

;; PLATO specs.

;;;;;;;;;;;;;;;; Components ;;;;;;;;;;;;;;;;;;;;;

(defstruct PLATO
  cpu
  rpu
  apu)

(defstruct CPU )
(defstruct RPU ) ;; raster
(defstruct APU )  ;; audio


;;;;;;;;;;;;;;;; Graphics ;;;;;;;;;;;;;;;;;;;;;;;

;; orange and black pixels
;;
;; xy char: 101 - 3264, line 1 char 1 - line 32 char 64
;; xy fine: 0,0 lower left - 511,511 top right

(defparameter display-width 512)
(defparameter display-height 512)
(defparameter char-width 8)
(defparameter char-height 16)
(defparameter char-set-1 nil) ;; builtin
(defparameter char-set-2 nil) ;; reserved
(defparameter char-set-3 nil) ;; user
(defparameter char-set-4 nil) ;; custom

;; draw, lift pen, etc


;;;;; sprites

(defclass Layer ()
  )

(defclass Triangle ()
  (color3
   pos3
   tag3))


