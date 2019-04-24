(define-module (nova)
  #:use-module (system foreign)
  #:export (Init Shutdown Update EndFrame))

(define novalib (dynamic-link "./nova.so"))

(define Init
  (pointer->procedure
   void
   (dynamic-func "NV_Init" novalib) (list size_t size_t)))
(define Shutdown
  (pointer->procedure void (dynamic-func "NV_Shutdown" novalib) '()))
(define Update
  (pointer->procedure size_t (dynamic-func "NV_Update" novalib) '()))
(define EndFrame
  (pointer->procedure void (dynamic-func "NV_EndFrame" novalib) '()))

;; graphics

;; (use-modules (srfi srfi-9))
;; (define-record-type )



;;(load "geometry.scm")
;;(load "winding.scm")
;;(load "database.scm")   ;; resources
;;(load "procedure.scm")
;;(load "part.scm")

;; program

(define-class <nova> (<object>)
  (game #:allocation #:virtual
        #:setter (lambda (x))
        #:getter (lambda (x))))

(define (mainLoop)
  (spawn-coop-repl-server)
  (while (Update)
    (poll-coop-repl-server)))

;; start

(define (start)
  (call-with-prompt 'nova-start nova-start (lambda (x ...))))
