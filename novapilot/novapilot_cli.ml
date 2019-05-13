(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* module Draw = Draw.Make(Cairo) *)
module Engine = System_glfw.Engine.Make(Novapilot)
let () = Engine.run "Novapilot"

