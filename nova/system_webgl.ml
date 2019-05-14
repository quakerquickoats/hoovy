(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

open Js_of_ocaml
(* open Js_of_ocaml_lwt *)
open Js
            
(* let () =
 *   Js.export "draw"
 *     (fun canvas -> Draw.testArc (JsOfOCairo.create canvas)) *)

let error f =
  Printf.ksprintf
    (fun s ->
      Firebug.console##error (Js.string s);
      failwith s)
    f

let debug f = Printf.ksprintf (fun s ->
                  Firebug.console##log (Js.string s)) f

let alert f =
  Printf.ksprintf
    (fun s ->
      Dom_html.window##alert (Js.string s);
      failwith s)
    f

let check_error gl = if gl##getError <> gl##._NO_ERROR_ then
                       error "WebGL error"
  
let init_canvas canvas_id =
  let canvas =
    Opt.get
      (Opt.bind
         (Dom_html.document##getElementById (string canvas_id))
         Dom_html.CoerceTo.canvas)
      (fun () -> error "can't find canvas element %s" canvas_id)
  in
  let gl =
    Opt.get
      (try WebGL.getContext canvas with _ -> null)
      (fun () -> alert "can't initialise WebGL context")
  in
  canvas, gl
  
let start _ =
  let _canvas, _gl = init_canvas "nova" in
  _true


let init () = Dom_html.window##.onload := Dom_html.handler start

