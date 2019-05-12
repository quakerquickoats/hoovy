(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open GLFW

open Tgl3
   
module System = struct
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
    
    let w = GLFW.createWindow ~width ~height ~title () in
    GLFW.makeContextCurrent ~window:(Some w);
    GLFW.setInputMode ~window:w ~mode:StickyKeys ~value:true;
    w

  let update window =
    GLFW.pollEvents ();
    if (GLFW.getKey ~window ~key:GLFW.Escape) ||
         (GLFW.windowShouldClose ~window) then false
    else true

  let endFrame window =
    GLFW.swapBuffers ~window
    
  let shutdown window =
    GLFW.destroyWindow ~window;
    GLFW.terminate ()

  let getKey window key =
    GLFW.getKey ~window ~key
end
