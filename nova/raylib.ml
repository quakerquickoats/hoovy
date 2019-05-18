open Foreign
open Ctypes

let foreign_void x = foreign x (void @-> returning void)
let foreign_bool x = foreign x (void @-> returning bool)

let initWindow =
  foreign "InitWindow" (int @-> int @-> string @-> returning void)
let closeWindow = foreign_void "CloseWindow"
let isWindowReady = foreign_bool "IsWindowReady"
let windowShouldClose = foreign_bool "WindowShouldClose"

let setTargetFPS = foreign "SetTargetFPS"(int @-> returning void)
let getFPS = foreign "GetFPS" (void @-> returning int)
let getFrameTime = foreign "GetFrameTime" (void @-> returning float)
let getTime = foreign "GetTime" (void @-> returning double)


(* let clearBackground = foreign_void "ClearBackground" *)
let beginDrawing = foreign_void "BeginDrawing"
let endDrawing = foreign_void "EndDrawing"
let beginMode2D = foreign_void "BeginMode2D"
let endMode2D = foreign_void "EndMode2D"

type color
let color: color structure typ = structure "Color"
let color_r = field color "r" char
let color_g = field color "g" char
let color_b = field color "b" char
let color_a = field color "a" char
let () = seal color
let makeColor (r,g,b,a) =
  let c = make color in 
  setf c color_r r;
  setf c color_g g;
  setf c color_b b;
  setf c color_a a;
  c

type vector3
let vector3: vector3 structure typ = structure "Vector3"
let vector3_x = field vector3 "x" float
let vector3_y = field vector3 "y" float
let vector3_z = field vector3 "z" float
let () = seal vector3
let makeVector3 (x,y,z) =
  let v = make vector3 in
  setf v vector3_x x;
  setf v vector3_y y;
  setf v vector3_z z;
  v

type vector4
let vector4: vector3 structure typ = structure "Vector4"
let vector4_x = field vector4 "x" float
let vector4_y = field vector4 "y" float
let vector4_z = field vector4 "z" float
let vector4_w = field vector4 "w" float
let () = seal vector4
let makeVector4 (x,y,z,w) =
  let v = make vector4 in
  setf v vector4_x x;
  setf v vector4_y y;
  setf v vector4_z z;
  setf v vector4_w w;
  v

let colorToInt = foreign "ColorToInt" (color @-> returning int)
(* let colorNormalize = foreign "ColorNormalize" (color @-> returning Nova.Geom.v4)
 * let colorToHSV = foreign "ColorToHSV" (color @-> returning Nova.Geom.v4) *)
let getColor = foreign "GetColor" (int @-> returning color)
let fade = foreign "Fade" (color @-> float @-> returning color)
                      
let clearBackground = foreign "ClearBackground" (color @-> returning void)
              
type vector2
let vector2: vector2 structure typ = structure "Vector2"
let x = field vector2 "x" float
let y = field vector2 "y" float
let () = seal vector2
              
type camera2d
let camera2d: camera2d structure typ = structure "Camera2D"
let offset  = field camera2d "offset" vector2
let target = field camera2d "target" vector2
let rotation = field camera2d "rotation" float
let zoom = field camera2d "zoom" float
let () = seal camera2d
           

let drawRectangle = foreign "DrawRectangle"
                      (int @-> int @-> int @-> int @-> color
                       @-> returning void)
