(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module Draw = Draw.Make(JsOfOCairo)

let () =
  Js_of_ocaml.Js.export "draw"
    (fun canvas -> Draw.testArc (JsOfOCairo.create canvas))
