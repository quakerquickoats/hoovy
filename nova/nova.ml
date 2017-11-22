open Tsdl
open Result

let init () =
  match Sdl.init Sdl.Init.(video + timer + audio + events) with
  | Error (`Msg e) -> Sdl.log "Init error: %s" e; exit 1
  | Ok () ->
      (* http://erratique.ch/software/tsdl/doc/Tsdl.Sdl.Window.html#TYPEflags *)
      match Sdl.create_window ~w:512 ~h:512 "Novapilot" Sdl.Window.opengl with
     | Error (`Msg e) -> Sdl.log "Create window error: %s" e; exit 1
     | Ok w ->
        match Sdl.create_renderer w with
        | Error (`Msg e) -> Sdl.log "Fail to create renderer: %s" e; exit 1
        | Ok r ->
           Sdl.log "Init OK...";
           Sdl.delay 3000l;
           (w,r)

let quit (w,r) =
  Sdl.destroy_renderer r;
  Sdl.destroy_window w;
  Sdl.quit ();
  exit 0
           
