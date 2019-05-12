(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open GLFW

open Tgl3
   
module System = struct
  type t = {
      window: window;
      width: int;
      height: int;
    }
  
  let rec checkErrors tag =
    let e = Gl.get_error () in
    if e <> Gl.no_error then begin
        print_string tag;
        print_string " : GL error: ";
        print_int e;
        print_newline ();
        checkErrors tag
      end
    else begin
        print_string tag;
        print_string " : No further errors.";
        print_newline ()
      end
  
  let init width height title =
    GLFW.init ();
    windowHint ~hint:WindowHint.ContextVersionMajor ~value:3;
    windowHint ~hint:WindowHint.ContextVersionMinor ~value:3;
    windowHint ~hint:WindowHint.OpenGLProfile ~value:CoreProfile;
    windowHint ~hint:WindowHint.RefreshRate ~value:(Some 60);
    windowHint ~hint:WindowHint.DepthBits ~value:None;
    
    let window = GLFW.createWindow ~width ~height ~title () in
    GLFW.makeContextCurrent ~window:(Some window);
    GLFW.setInputMode ~window ~mode:StickyKeys ~value:true;
    (* need to return actual window size.
       EXWM does full screen by default. *)
    let w,h = GLFW.getWindowSize ~window in
    {width=w;height=h;window}
 
  let shutdown {window;_} =
    GLFW.destroyWindow ~window;
    GLFW.terminate ()

  let update {window;_} =
    GLFW.pollEvents ();
    if (GLFW.getKey ~window ~key:GLFW.Escape) ||
         (GLFW.windowShouldClose ~window) then false
    else true

  let getTime = GLFW.getTime
  let endFrame {window;_} = GLFW.swapBuffers ~window
  let getKey {window;_} key = GLFW.getKey ~window ~key
end
