(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module System = System_html5
module Draw = Draw.Make(JsOfOCairo)

open Js_of_ocaml
            
let () =
  (* let sys = System.init 512 512 "nova" in *)
  Js.export "draw" (fun canvas ->
      let c = (JsOfOCairo.create canvas) in
      Draw.testArc c;
      Draw.text c (string_of_float (System.getTime ())
    ))
  (* System.init () *)
