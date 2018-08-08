(in-package :humaweb)

(defparameter *js-files* '())
(defparameter *css-files* '("style"))

(defun output (&key (dir "./www"))
  (output-project :dir dir
                  :width 32
                  :height 24
                  :scale 32
                  :html '() ;;'("play")   ;; FIXME: broken html output
                  :js *js-files*
                  :css *css-files*))

(define-htmloutput play
    :title "humasect 4drl"
    :styles *css-files*
    :scripts *js-files*
    :body (htm
           (:h2 "humasect 4drl")
           (:canvas
            :id "screen-canvas"
            :width (* *screen-width* *layer-scale*)
            :height (* *screen-height* *layer-scale*))))

(define-cssoutput style
  (("html") (:background "rgb(0, 0, 0)"
             :background-image "none"
             :min-height "100%"))
  (("body") (:-webkit-user-select "none"
             :-moz-user-select "none"
             :overflow "hidden"
             :margin "0px"
             :color "white"))

  ((".tile") (:font-size "30px"
              :position "absolute"
              :width "24px"
              :height "30px"
              :text-align "left"

              :vertical-align "text-bottom"
              :margin 0
              :padding 0))

  ((".floor") (:background "blue"))
  ((".wall") (:background "green"))
  )

(define-jsoutput game
  (var *pieces* nil)
  (var *actors* nil)
  
  (defun redraw ()
    (layer-render *screen*))

  (defun start-main ()
    ;; set up temp level pieces
    (setf *pieces* (layer-make :name "*pieces*" :contents 'empty))
    (layer-add-sublayer *screen* *pieces*)
    (layer-add-sublayers *pieces*
                         (list (layer-make
                                :name "test-left"
                                :fill-style "red"
                                :bounds (rect-make 5 10 5 5))
                               (layer-make
                                :name "test-right"
                                :fill-style "green"
                                :bounds (rect-make 20 10 5 5))))
    
    ;; set up actors
    (setf *actors* (layer-make :name "*actors*" :contents 'empty))
    (layer-add-sublayer *screen* *actors*)
    (layer-add-sublayers *actors* (list (actor-make "Player" "@" 2 2)
                                        (actor-make "Monster" "M" 10 10)))

    (setprop *screen* fill-style "blue")
    (clog *screen*)
    (redraw))

  (defun game-turn (angle)
    ;;(clogf "take a turn, angle: " angle)
    (actor-move (sublayer-named *actors* "Player") angle)
    (redraw))

  (setf (@ document onkeydown)
        (lambda (e)
          (let* ((angle-map (create
                             "d" 270
                             "b" 180
                             "f" 90
                             "h" 0

                             "g" 315
                             "i" 45
                             "c" 135
                             "a" 225))
                 (s ((@ *string from-char-code)
                     (or (@ e which) (@ e key-code))))
                 (a (getprop angle-map s)))
            (if (= undefined a)
                (clogf "unknown key: " s)
                (game-turn a)))))
  )
