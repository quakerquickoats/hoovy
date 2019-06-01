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
;=> t/f

(apple eats tree)
;=> t/f

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(a do: something)


(app = (Application new))
(app setTitle: "Test")
((app window) show)

(def set (a b)
     )

(let = (symbol )
     (Symbols named: symbol setTo: value))

(let Application (Class slots: '(window))
  (let setTitle: t)
  (let show
      (Gfx.perform))
  )

;;;;

(let create: Array withSize: n)

(let x (Array create: ))

;; <obj> <msg> <arg
;; <SUBJ> <VERB> <OBJ


;;     about half of the world's languages deploy subject–object–verb order(SOV);
;;     about one-third of the world's languages deploy subject–verb–object order(SVO);
;;     a smaller fraction of languages deploy verb–subject–object (VSO) order;
;;     the remaining three arrangements are rarer: verb–object–subject (VOS) is slightly more
;;     common than object–verb–subject (OVS),
;;     and object–subject–verb (OSV) is the rarest by a significant margin[7]

;; SOV
(joe, apple eat)
(number, add number)
(string, compareWith: string)

;; SVO
(joe, eat apple)

;; VSO
(eat joe: apple)

;; VOS
(eat apple, joe)

;; OVS
(apple eat: joe)

;; OSV
(apple, joe eat)


;;;;;;
;; Joe is subject.
;; verb: is verb.
;; object is object.
;;
;; sov
(JOE Apple eat)
;; svo
(JOE eat Apple)
;; vso
()

;;;;;;;

(subject: joe)
(object: apple)
(verb: eat)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; eval to the middle
{left middle right}
{one three two}

;; eval middle.
(one two three)

;; eval to the right
>first second third fourth>

;; eval to the left
<fourth third second first<

><second first< third <fifth fourth< sixth>
;; translation:
((first second) third (fourth fifth) sixth)

;;;;;;;;;;;;;;;

(/ (* 12 (+ 3 4)) 100)

;; (12 * (3 + 4)) / 100
;; just swap the first two args.

>>12 * <4 + 3<> / 100>
<100 / >12 * {+ 4 3}><

<<12 8 >4 + 3>< / 100<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;one = atom
;;two = expression
;;three = statement

(1) ;; =>
(lambda (a b) `(1 ,a ,b))

(1 +) ;; =>
(lambda (a) `(1 + ,a))

(1 + 2) ;; =>
(3)

((1 +) 2)  ;; =>
()



