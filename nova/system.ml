open Tsdl
open Result

open Nova

module System (G: Nova.Game) = struct
  type t = {
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
                  (fun r -> {w; r; ctx; game=G.initial_state();}))))

  let handle_events sys =
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
    Sdl.gl_swap_window sys.w;
    Sdl.delay 10l;
    !stop
    
  let rec run sys =
    match handle_events sys with
    | true -> sys
    | false -> run {sys with game = G.step sys.game}

  let play () =
    let sys = init () in
    quit (run sys)
end
