open Tsdl
open Result

type input = int

let update_game g tick =
  Sdl.log "Update game %f" tick

type 'g engine = {
    last_time: int;
    input_state: input;
    game: 'g;
    running: bool;
    tick_mul: float;
  }

let new_engine () = {
    last_time = 0;
    input_state = 10000;
    game = ();
    running = false;
    tick_mul = 1.0;
  }
               
  (*
  let c_dt = Int64.sub (Sdl.get_performance_counter ()) c in
  let freq = Sdl.get_performance_frequency () in
  let c_dt = ((Int64.to_float c_dt) /. ((Int64.to_float freq) /. 1000.)) in
   *)
  
let step en =
  let before = en.last_time in
  let now = Int32.to_int (Sdl.get_ticks ()) in
  let tick = (float_of_int (now - before)) /. 1000. in
  { en with
    last_time = now;
    game = (update_game en.game (tick *. en.tick_mul));
  }
             

type state = {
    w: Sdl.window;
    r: Sdl.renderer;
    ctx: Sdl.gl_context;
  }
   
let quit (w,r,ctx) =
  Sdl.destroy_renderer r;
  Sdl.destroy_window w;
  Sdl.gl_delete_context ctx;
  Sdl.quit ();
  exit 0

let init () =
  match Sdl.init Sdl.Init.(video + timer + audio + events) with
  | Error (`Msg e) -> Sdl.log "Init error: %s" e; exit 1
  | Ok () ->
     (* http://erratique.ch/software/tsdl/doc/Tsdl.Sdl.Window.html#TYPEflags *)
     Sdl.log "Init OK...";
     Sdl.gl_set_attribute Sdl.Gl.doublebuffer 1;
     match Sdl.create_window ~w:512 ~h:512 "Novapilot" Sdl.Window.opengl with
     | Error (`Msg e) -> Sdl.log "Create window error: %s" e; exit 1
     | Ok w ->
        Sdl.set_window_position w ~x:0 ~y:0;
        match Sdl.gl_create_context w with
        | Error (`Msg e) -> Sdl.log "OpenGL context error: %s" e; exit 1
        | Ok ctx ->
           let (Ok x) = Sdl.gl_get_attribute Sdl.Gl.context_major_version in
           let (Ok y) = Sdl.gl_get_attribute Sdl.Gl.context_minor_version in
           Sdl.log "GL Version: %i.%i" x y;
           match Sdl.create_renderer w with
           | Error (`Msg e) -> Sdl.log "Fail to create renderer: %s" e; exit 1
           | Ok r ->
              let e = Sdl.Event.create () in
              let rec loop state = match Sdl.wait_event (Some e) with
                | Error (`Msg e) -> Sdl.log "Could not wait event: %s" e; exit 1 (* () *)
                | Ok () ->
                   match Sdl.Event.(enum (get e typ)) with
                   | `Quit ->
                      (* Sdl.pause_audio_device device_id true; *)
                      quit state
                   | _ ->
                      Sdl.gl_swap_window w;
                      loop state
              in
              loop (w,r,ctx)


           
