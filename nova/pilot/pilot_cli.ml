(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* module Draw = Draw.Make(Cairo) *)

module Game = Nova_cli.System_glfw.Conductor(Pilot)
let () = Game.run "Novapilot"

