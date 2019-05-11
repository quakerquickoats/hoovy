open Tsdl
open Result

open Nova
open Play

module System (G: Play.Game) = struct
  type t = {
      last_time: float;
      tick_mul: float;
      
      w: Sdl.window;
      r: Sdl.renderer;
      ctx: Sdl.gl_context;
      
      game: G.t;
    }

  let quit {w;r;ctx;game;} =
    G.cleanup game;
    Sdl.gl_delete_context ctx;
    Sdl.destroy_renderer r;
    Sdl.destroy_window w;
    Sdl.quit ();
    exit 0

  let err s e = Sdl.log s e; exit 1
  let handler x l r =
    match x with
      Error (`Msg e) -> l e
    | Ok a -> r a

  let init () =
    handler (Sdl.init Sdl.Init.(video + timer + audio + events))
      (* TODO: put this pattern in another handler fun *)
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
                  (fun r -> {w; r; ctx; game=G.initial_state();
                             last_time = Unix.gettimeofday();
                             tick_mul = 1.}))))

  let handle_key_down sys k =
    if k == Sdl.K.z then Sdl.log "zed"; (* sys.make_happen sys.game; *)
    if k == Sdl.K.q then true else false
(*    match k with
      Sdl.K.z -> sys.game.make_happen(); false
    | Sdl.K.q -> true
    | _ -> Sdl.log "key event, %x" k; false *)
    
  let handle_events sys =
    let e = Sdl.Event.create() in
    let stop = ref false in
    while (Sdl.poll_event (Some e)) && (not !stop) do
      stop := match Sdl.Event.(enum (get e typ)) with
              | `Key_down -> handle_key_down sys Sdl.Event.(get e keyboard_keycode) 
              (*| `Key_up -> false
                | `Mouse_motion -> false  
                | `Mouse_button_down -> false
                | `Mouse_button_up -> ()
                | `Finger_motion -> () *)
              | `Quit -> true;
              | _ -> Sdl.log "event = %x" Sdl.Event.(get e typ); false
    done;
    Sdl.gl_swap_window sys.w;
    Sdl.delay 10l;
    !stop
    
  let rec run sys =
    let before = sys.last_time in
    let now = Unix.gettimeofday() in
    let tick = (now -. before) in
    match handle_events sys with
    | true -> sys
    | false ->
       run {sys with last_time = now;
                     game = G.step sys.game (tick *. sys.tick_mul);}

  let play () =
    let sys = init () in
    quit (run sys)
end
