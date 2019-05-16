(*
  Gamelike
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
  Cairo.PNG.write (Render.getSurface canvas)
    "last_picture.png";
  GLFW.destroyWindow ~window;
  GLFW.terminate ()
  
let update {window;_} =
  GLFW.pollEvents ();
  if (GLFW.getKey ~window ~key:GLFW.Escape)
     || (GLFW.windowShouldClose ~window) then false
  else true

let getKey {window;_} key = GLFW.getKey ~window ~key

(*******************************************)

module Draw = Draw.Make(Cairo)


let drawTest ctx tick =
  Draw.withState ctx (fun c ->
      Draw.clear c;
      Cairo.set_source_rgb c 0. 1. 1.;
      Cairo.set_font_size c 22.;
      Cairo.move_to c 144. 144.;
      Draw.text c (string_of_float (1. /. tick));
      
      Draw.text c "[ 👽 ]";
    );
  Draw.testArc ctx

let run title create step =
  let sys = init 320 240 title in
  let rec loop {window;canvas;context;_} e =
    if update sys then begin
        (* let now = GLFW.getTime () in
         * let tick = now -. lastTime in *)
        Render.prepareCanvas canvas;
          
        Gl.clear_color 1. 0.5 1. 1.;
        Gl.clear Gl.color_buffer_bit;

        (* List.iter (Draw.gear context) e.gears
         * drawTest sys.context 0.004;(\* tick; *\) *)
        List.iter (Draw.gear context) [1;2;3];
          
        (* only needed if changed. *)
        Render.uploadCanvas canvas;
          
        Render.renderCanvas canvas;
        GLFW.swapBuffers ~window;
        loop sys (step e (GLFW.getTime()))
      end
  in
  loop sys (create (GLFW.getTime()));
  shutdown sys

  
(* module Make(E: Nova.Engine.S) = struct
 *   let run title =
 *     let e = E.initialState in
 *     let sys = init 320 240 title in
 *     let rec loop {window;canvas;_} e lastTime =
 *       if update sys then begin
 *           let now = GLFW.getTime () in
 *           let tick = now -. lastTime in
 *           Render.prepareCanvas canvas;
 *           
 *           Gl.clear_color 1. 0.5 1. 1.;
 *           Gl.clear Gl.color_buffer_bit;
 * 
 *           drawTest sys.context tick;
 * 
 *           (\* only needed if changed. *\)
 *           Render.uploadCanvas canvas;
 *           
 *           Render.renderCanvas canvas;
 *           GLFW.swapBuffers ~window;
 *           loop sys (E.step e tick) now
 *         end
 *       else
 *         E.cleanup e
 *     in
 *     loop sys e (GLFW.getTime());
 *     shutdown sys
 * end *)

