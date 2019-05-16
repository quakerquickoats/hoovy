(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* module Draw = Draw.Make(Cairo) *)

module System = Nova_cli.System_glfw
(* .Make(Pilot) *)
module Engine = Nova.Engine.Make(Pilot)
              
let () =
  System.run "Novapilot"
           Engine.create
           Engine.step

           
