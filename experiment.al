;; -*- lisp -*-
;;
;;

;; needs to be gender, dual.
;; single is male, multi is female

;;
;;
;; UpperCase is variable. defined and set if not already.
;;
;; lowerOrCamelCase is stack/scope dictionary
;;
(tree eats apple)
=> t/f

(apple eats tree)
=> t/f

(Tree eats Apple)
Tree = nil
Apple = nil
=> t/f

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; eval backward and forward.
;;

;; polish def
(A eats B
   ;;(print A, print " eats ", print B)
   (print (++ A " eats " B))
   )

(start [world] end)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; objects like smalltalk?
;;
(1 countTo: 10)
("Hello" print)

(@code Object:
       (
        ;; methods
        ))

(@data Object:
       (
        ;; member vars
        ))

;;;;;;;;;;;
;;
;; traits?
;;
(Number method: show
        body: (...)
        )

($Arglist method: $Name body: $Body)

