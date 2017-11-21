open Tsdl
open Result

let init () = match Sdl.init Sdl.Init.video with
  | Error (`Msg e) -> Sdl.log "Init error: %s" e; exit 1
  | Ok () ->
     match Sdl.create_window ~w:512 ~h:512 "Novapilot" Sdl.Window.opengl with
     | Error (`Msg e) -> Sdl.log "Create window error: %s" e; exit 1
     | Ok w ->
        Sdl.delay 3000l;
        Sdl.destroy_window w;
        Sdl.quit ();
        exit 0


           
