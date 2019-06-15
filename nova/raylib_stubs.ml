open Foreign

   
module Bindings (F : Cstubs.FOREIGN) = struct
  open F
  let void = Ctypes.void
  let bool = Ctypes.bool
  let int = Ctypes.int
  let string = Ctypes.string
  let foreign_void x = F.foreign x (void @-> returning void)
  let foreign_bool x = F.foreign x (void @-> returning bool)

  let initWindow =
    F.foreign "InitWindow" (int @-> int @-> string @-> returning void)
  let closeWindow = foreign_void "CloseWindow"
  let isWindowReady = foreign_bool "IsWindowReady"
  let windowShouldClose = foreign_bool "WindowShouldClose"
  let isWindowMinimized = foreign_void "IsWindowMinimized"
  let toggleFullscreen = foreign_void "ToggleFullscreen"
  (* let setWindowIcon = F.foreign "SetWindowIcon" (image @-> returning void) *)
  let setWindowTitle = F.foreign "SetWindowTitle" (string @-> returning void)
  let setWindowPosition = F.foreign "SetWindowPosition" (int @-> int @-> returning void)
  let setWindowMonitor = F.foreign "SetWindowMonitor" (int @-> returning void)
  let setWindowMinSize = F.foreign "SetWindowMinSize" (int @-> int @-> returning void)
  let setWindowSize = F.foreign "SetWindowSize" (int @-> int @-> returning void)
  let getScreenWidth = F.foreign "GetScreenWidth" (void @-> returning int)
  let getScreenHeight = F.foreign "GetScreenHeight" (void @-> returning int)

end

let writeFile s f =
  let out = open_out s in
  f (Format.formatter_of_out_channel out);
  close_out out

(* let genStubs s x =
 *   let out = open_out s in
 *   x (Format.formatter_of_out_channel out) "raylib"
 *     (module Raylib_stubs.Bindings);
 *   close_out out *)

let runTheTrap () =
  writeFile "_stub.ml"
    (fun fmt -> Cstubs.write_ml fmt ~prefix:"raylib"
               (module Bindings));
  writeFile "_stub.c"
    (fun fmt -> Cstubs.write_c fmt ~prefix:"raylib"
               (module Bindings));

  (* genStubs "_rl_stub.ml" (Cstubs.write_ml);
   * genStubs "_rl_stub.c" (Cstubs.write_c) *)
