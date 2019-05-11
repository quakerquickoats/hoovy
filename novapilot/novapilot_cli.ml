
let () = begin
  let module Nova = Nova.Make(Cairo) in
  let image = Cairo.Image.create Cairo.Image.ARGB32 ~w:100 ~h:100 in
  Nova.draw (Cairo.create image);
  Cairo.PNG.write image "novapilot_cli.png";
end

let () = begin
  let module Nova = Nova.Make(CairoMock) in
  let ctx = CairoMock.create () in
  Nova.draw ctx;
  assert (CairoMock.calls ctx = ["save"; "arc 50.00 50.00 ~r:40.00 ~a1:0.00 ~a2:5.00"; "stroke"; "restore"])
end
