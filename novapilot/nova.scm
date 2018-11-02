(define-module (nova)
  #:use-module (system foreign)
  #:export ()
  )

(define novalib (dynamic-link "nova"))

(define Init
  (pointer->procedure void (dynamic-func "NV_Init" novalib)))
(define Shutdown
  (pointer->procedure void (dynamic-func "NV_Shutdown" novalib)))
(define Update
  (pointer->procedure size_t (dynamic-func "NV_Update" novalib)))
(define EndFrame
  (pointer->procedure void (dynamic-func "NV_EndFrame" novalib)))


