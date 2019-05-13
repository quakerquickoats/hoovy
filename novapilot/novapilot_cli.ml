(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module System = System_glfw
module Draw = Draw.Make(Cairo)

let () =
  let sys = System.init 320 240 "Novapilot" in
  (* let w = sys.width and h = sys.height in *)

  (* let img = Cairo.Image.(create ARGB32 ~w ~h) in *)
  (* let c = Cairo.create sys.canvas.surface in *)
  (* let _p = Render.createShader () in *)
  (* let c = Render.createCanvas w h in *)

  let draw c t =
    Draw.withState c (fun () ->
        Draw.clear c;
        Cairo.set_source_rgb c 0. 1. 1.;
        Cairo.set_font_size c 22.;
        Cairo.move_to c 144. 144.;
        Draw.text c (string_of_float (1. /. t));
      );
    Draw.testArc c
  in
  System.loop sys draw
    
