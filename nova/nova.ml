open Tsdl
open Result
open Gg
   
type input = {
    up_arrow: bool; down_arrow: bool; left_arrow: bool; right_arrow: bool;
    char_states: char * bool;
    move_vector: v2;

    left_button: bool; middle_button: bool; right_button: bool;

(*    type cursor = {
        c: V2;
        last: V2;
        delta: V2;
      } *)
    cursor: v2; last_cursor: v2; delta: v2;
    screen_cursor: v2; last_screen_cursor: v2; screen_delta: v2;
  }

let no_input = {
    up_arrow = false; down_arrow = false; left_arrow = false; right_arrow = false;
    char_states = ('a',false);
    move_vector = V2.zero;
    left_button = false; middle_button = false; right_button = false;
    cursor = V2.zero; last_cursor = V2.zero; delta = V2.zero;
    screen_cursor = V2.zero; last_screen_cursor = V2.zero; screen_delta = V2.zero;
  }

let set_input_char i x b = {i with char_states = ('b',true)} (*map.insert x b (char_states i)*)

module Engine = struct
  type t = {
      last_time: float;
      input_state: input;
      running: bool;
      tick_mul: float;
    } [@@deriving sexp]

  let create g = {
      last_time = Unix.gettimeofday();
      input_state = no_input;
      running = false;
      tick_mul = 1.0;
    }

  let step en =
    let before = en.last_time in
    (* let now = Int32.to_int (Sdl.get_ticks ()) in *)
    let now = Unix.gettimeofday () in
    let tick = (now -. before) in
    Sdl.log "last %f now %f" before now;
    { en with
      last_time = now;
      (* game = (update_game en.game ((tick *. en.tick_mul) /. 1000.)); *)
    }
end
type engine = Engine.t

  (*
  let c_dt = Int64.sub (Sdl.get_performance_counter ()) c in
  let freq = Sdl.get_performance_frequency () in
  let c_dt = ((Int64.to_float c_dt) /. ((Int64.to_float freq) /. 1000.)) in
   *)

let update_game g tick =
  Sdl.log "Update game %f" tick

(**********)

module System = struct
  type t = {
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
       ignore (Sdl.gl_set_attribute Sdl.Gl.doublebuffer 1);
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
end
type system = System.t  





