(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* module Draw = Draw.Make(Cairo) *)
module Game = Nova.System_glfw.Conductor.Make(Novapilot)
let () = Game.run "Novapilot"

