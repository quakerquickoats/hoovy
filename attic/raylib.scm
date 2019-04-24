(define-module (novapilot raylib)
  #:use-module (system foreign)
  #:export ())

(define raylib (dynamic-link "libraylib"))

(define InitWindow
  (pointer->procedure void
                      (dynamic-func "InitWindow" raylib)
                      (list size_t size_t '*)))

(define CloseWindow
  (pointer->procedure void (dynamic-func "CloseWindow" raylib)))

(define WindowShouldClose
  (pointer->procedure BOOL (dynamic-func "WindowShouldClose" raylib)))

(define BeginDrawing
  (pointer->procedure void (dynamic-func "BeginDrawing" raylib)))

(define EndDrawing
  (pointer->procedure void (dynamic-func "EndDrawing" raylib)))
