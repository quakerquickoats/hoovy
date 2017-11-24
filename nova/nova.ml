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

(********************************************************)

module Engine = struct
  type t = int
end
type engine = Engine.t

let update_game g tick =
  Sdl.log "Update game %f" tick

module Machine = struct
  type t = {
      last_time: float;
      running: bool;
      tick_mul: float;
      input_state: input;
    } [@@deriving sexp]

  let create g = {
      last_time = Unix.gettimeofday();
      running = false;
      tick_mul = 1.0;
      input_state = no_input;
    }

  let step en =
    let before = en.last_time in
    (* let now = Int32.to_int (Sdl.get_ticks ()) in *)
    let now = Unix.gettimeofday () in
    let tick = (now -. before) in
    Sdl.log "last %f now %f tick %f" before now tick;
    { en with
      last_time = now;
      (* game = (update_game en.game ((tick *. en.tick_mul) /. 1000.)); *)
    }
end

(* Machine *)

module type Game = sig
  type t
  (* clock, heart, breath, rhythm, beat *)
  val up: unit -> t
  val step: t -> t
  val render: t -> unit
  val down: unit -> unit
end

module System (G: Game) = struct

  (* let create up step render down = {up; step; render; down;} *)

  type t = {
      w: Sdl.window;
      r: Sdl.renderer;
      ctx: Sdl.gl_context;
      game: G.t;
    }

  let quit {w;r;ctx;game;} =
    G.down ();
    Sdl.destroy_renderer r;
    Sdl.destroy_window w;
    Sdl.gl_delete_context ctx;
    Sdl.quit ();
    exit 0

  let err s e = Sdl.log s e; exit 1
  let handler x l r =
    match x with
    | Error (`Msg e) -> l e
    | Ok a -> r a

  let init () =
    handler (Sdl.init Sdl.Init.(video + timer + audio + events))
      (fun e -> err "Init error: %s" e)
      (fun _ ->
        Sdl.log "Init OK...";
        ignore (Sdl.gl_set_attribute Sdl.Gl.doublebuffer 1);
        handler (Sdl.create_window ~w:512 ~h:512 "Novapilot" Sdl.Window.opengl)
          (fun e -> err "Create window error: %s" e)
          (fun w ->
            handler (Sdl.gl_create_context w)
              (fun e -> err "OpenGL context error: %s" e)
              (fun ctx ->
                let x = handler (Sdl.gl_get_attribute Sdl.Gl.context_major_version)
                          (fun _ -> 0) (fun x -> x) in
                let y = handler (Sdl.gl_get_attribute Sdl.Gl.context_minor_version)
                          (fun _ -> 0) (fun y -> y) in
                Sdl.log "GL Version: %i.%i" x y;
                handler (Sdl.create_renderer w)
                  (fun e -> err "Fail to create renderer: %s" e)
                  (fun r -> {w; r; ctx; game=G.up();}))))

  let handle_events () =
    let e = Sdl.Event.create() in
    let stop = ref false in
    while (Sdl.poll_event (Some e)) && (not !stop) do
      match Sdl.Event.(enum (get e typ)) with
      | `Key_down -> Sdl.log "key event, %x" Sdl.Event.(get e keyboard_keycode);
                     stop := (Sdl.Event.(get e keyboard_keycode) == Sdl.K.q);
(*          | `Key_up -> false
          | `Mouse_motion -> false
          | `Mouse_button_down -> false
          | `Mouse_button_up -> ()
          | `Finger_motion -> () *)
      | `Quit -> Sdl.log "quit event"; stop := true;
      | _ -> Sdl.log "event = %x" Sdl.Event.(get e typ)
    done;
    !stop
    
  let rec run game =
    let stop = handle_events () in
    Sdl.gl_swap_window game.w;
    Sdl.delay 10l;
    if not stop then run game
    
  let rec loop game =
    let e = Sdl.Event.create() in
    handler (Sdl.wait_event (Some e))
      (fun e -> err "Could not wait event: %s" e)
      (fun () ->
        match Sdl.Event.(enum (get e typ)) with
        | `Quit ->
           quit game
        | _ ->
           Sdl.gl_swap_window game.w;
           loop game)
end





