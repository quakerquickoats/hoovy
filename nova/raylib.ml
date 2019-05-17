open Foreign
open Ctypes

let initWindow =
  foreign "InitWindow" (int @-> int @-> string @-> returning void)
let windowShouldClose =
  foreign "WindowShouldClose" (void @-> returning bool)

let setTargetFPS = foreign "SetTargetFPS"(int @-> returning void)
let getFPS = foreign "GetFPS" (void @-> returning int)
let getFrameTime = foreign "GetFrameTime" (void @-> returning float)
let getTime = foreign "GetTime" (void @-> returning double)

let foreign_void x = foreign x (void @-> returning void)

let clearBackground = foreign_void "ClearBackground"
let beginDrawing = foreign_void "BeginDrawing"
let endDrawing = foreign_void "EndDrawing"
let beginMode2D = foreign_void "BeginMode2D"
let endMode2D = foreign "EndMode2D"
