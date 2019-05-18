(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

type t = {
    width: int;
    height: int;
  }

let init w h title =
  Raylib.initWindow w h title;
  Raylib.setTargetFPS 60;
  {width=w;height=h}

let pollEvents _sys =
  Raylib.windowShouldClose()

let beginFrame _sys =
  Raylib.beginDrawing()
  (* Raylib.clearBackground `White *)

let endFrame _sys =
  Raylib.endDrawing()
    
let shutdown _sys =
  Raylib.closeWindow()

let getTime =
  Raylib.getTime

let renderFrame _sys _m =
  ()