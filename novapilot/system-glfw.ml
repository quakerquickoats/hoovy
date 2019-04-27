(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(*open Gg
  open Ctypes
  open Foreign
 *)

open GLFW

module System = struct
  let init width height =
    GLFW.init ();
    windowHint ~hint:WindowHint.ContextVersionMajor ~value:3;
    windowHint ~hint:WindowHint.ContextVersionMinor ~value:3;
    windowHint ~hint:WindowHint.OpenGLProfile ~value:CoreProfile;
    windowHint ~hint:WindowHint.RefreshRate ~value:(Some 60);
    windowHint ~hint:WindowHint.DepthBits ~value:None;

    let w = GLFW.createWindow ~width:width ~height:height
                ~title:"Novapilot" () in
    GLFW.makeContextCurrent ~window:(Some w);
    print_string "OK.";

    GLFW.setInputMode ~window:w ~mode:StickyKeys ~value:true;
    w

  let update w =
    GLFW.pollEvents ();
    if (GLFW.getKey ~window:w ~key:GLFW.Escape) ||
         (GLFW.windowShouldClose ~window:w) then
      false
    else
      true

  let endFrame w =
    GLFW.swapBuffers ~window:w
    
  let shutdown w =
    GLFW.destroyWindow ~window:w;
    GLFW.terminate ();
end
                  
