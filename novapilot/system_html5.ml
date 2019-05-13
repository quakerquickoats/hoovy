(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* open Js_of_ocaml *)
(* open Js *)

(* let rec error _s _t =
 *   ()
 *    
 * let init w h title =
 *   let canvas =
 *     Opt.get
 *       (Opt.bind
 *          (Dom_html.document##getElementById (string title))
 *          Dom_html.CoerceTo.canvas)
 *       (fun () -> "can't find canvas element")
 *   in
 *   let context = (JsOfOCairo.create canvas) in
 *   (w, h, context) *)

let getTime () =
  0.
