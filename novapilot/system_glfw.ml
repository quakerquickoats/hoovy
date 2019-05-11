(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open GLFW

module System = struct
  let init width height title =
    GLFW.init ();
    windowHint ~hint:WindowHint.ContextVersionMajor ~value:3;
    windowHint ~hint:WindowHint.ContextVersionMinor ~value:3;
    windowHint ~hint:WindowHint.OpenGLProfile ~value:CoreProfile;
    windowHint ~hint:WindowHint.RefreshRate ~value:(Some 60);
    windowHint ~hint:WindowHint.DepthBits ~value:None;

    let w = GLFW.createWindow ~width ~height ~title () in
    GLFW.makeContextCurrent ~window:(Some w);
    print_string "OK.";
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
