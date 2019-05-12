(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module Nova = Nova.Make(JsOfOCairo)

let () =
  Js_of_ocaml.Js.export "draw"
    (fun canvas -> Nova.drawScene (JsOfOCairo.create canvas))
