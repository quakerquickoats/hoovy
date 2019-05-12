module Draw = Draw.Make(JsOfOCairo)

let () = Js_of_ocaml.Js.export "draw" (fun canvas ->
  Draw.scene (JsOfOCairo.create canvas)
)
