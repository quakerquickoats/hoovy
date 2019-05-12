(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open System_glfw

module Draw = Draw.Make(Cairo)

let () =
  let sys = System.init 320 240 "Novapilot" in
  let w = sys.width and h = sys.height in

  let img = Cairo.Image.(create ARGB32 ~w ~h) in
  let ctx = Cairo.create img in

  Draw.testArc ctx;
  (* Cairo.Surface.flush img; *)
  (* Cairo.Surface.finish i; *)

  let _p = Render.createShader () in
  let l = Render.createLayer w h img in
  
  let rec loop lastTime =
    let now = System.getTime () in
    let tick = now -. lastTime in
    if System.update sys then begin
        Render.initFrame w h;
        Cairo.save ctx;
        Cairo.set_source_rgba ctx 0. 0. 0. 0.;
        Cairo.set_operator ctx Cairo.SOURCE;
        Cairo.paint ctx;
        Cairo.set_operator ctx Cairo.OVER;
        Cairo.set_source_rgb ctx 0. 1. 1.;
        Cairo.set_font_size ctx 22.;
        Cairo.move_to ctx 44. 44.;
        Cairo.show_text ctx (string_of_float (1. /. tick));
        Cairo.restore ctx;
        Cairo.Surface.flush img;

        (* texture should already be bound. *)
        Render.updateLayer l w h img;
        
        System.endFrame sys;
        loop now
      end
    else
      ()
  in
  loop (System.getTime());
        
  Cairo.PNG.write img "novapilot_cli.png";
  System.shutdown sys
    


(* let () = begin
  let module Nova = Nova.Make(CairoMock) in
  let ctx = CairoMock.create () in
  Nova.draw ctx;
  assert (CairoMock.calls ctx = ["save"; "arc 50.00 50.00 ~r:40.00 ~a1:0.00 ~a2:5.00"; "stroke"; "restore"])
end
*)
