(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* module System = System_glfw *)
(* module Draw = Draw.Make(Cairo) *)
module System = System_glfw.Make(Novapilot)

let () = System.run "Novapilot"
            
(* let () =
 *   System.run "Novapilot" (fun c t ->
 *       Draw.withState c (fun () ->
 *           Draw.clear c;
 *           Cairo.set_source_rgb c 0. 1. 1.;
 *           Cairo.set_font_size c 22.;
 *           Cairo.move_to c 144. 144.;
 *           Draw.text c (string_of_float (1. /. t));
 *         );
 *       Draw.testArc c
 *     ) *)
    
