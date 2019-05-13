(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open GLFW
open Tgl3

type t = {
    width: int;
    height: int;
    window: GLFW.window;
    canvas: Render.image;
    context: Cairo.context;
  }
  
let rec checkErrors tag =
  let e = Gl.get_error () in
  if e <> Gl.no_error then begin
      print_string tag;
      print_string " : GL error: ";
      print_int e;
      print_newline ();
      checkErrors tag
    end else begin
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
  let _ = Render.createShaders () in
  let canvas = Render.createCanvas w h in
  let context = Cairo.create (Render.getSurface canvas) in
  {width=w;height=h;window;canvas;context}
 
let shutdown {window;canvas;_} =
  Cairo.PNG.write (Render.getSurface canvas) "last_picture.png";
  GLFW.destroyWindow ~window;
  GLFW.terminate ()
  
let update {window;_} =
  GLFW.pollEvents ();
  if (GLFW.getKey ~window ~key:GLFW.Escape)
     || (GLFW.windowShouldClose ~window) then false
  else true

let getKey {window;_} key = GLFW.getKey ~window ~key

module Make(G: Nova.Game) = struct
  let run title =
    let sys = init 320 240 title in
    let rec inner lastTime g =
      let now = GLFW.getTime () in
      let tick = now -. lastTime in
      if update sys then begin
          Render.prepareCanvas sys.canvas;
          
          Gl.clear_color 1. 0.5 1. 1.;
          Gl.clear Gl.color_buffer_bit;
          
          G.render g;
          Render.uploadCanvas sys.canvas; (* only needed if changed. *)
          Render.renderCanvas sys.canvas;
          GLFW.swapBuffers ~window:sys.window;
          inner now (G.step g tick)
        end
      else
        ()
    in
    inner (GLFW.getTime()) (G.start ());
    shutdown sys
end
                                      
