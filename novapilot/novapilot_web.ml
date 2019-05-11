module Nova = Nova.Make(JsOfOCairo)

let () = Js_of_ocaml.Js.export "draw" (fun canvas ->
  Nova.draw (JsOfOCairo.create canvas)
)
