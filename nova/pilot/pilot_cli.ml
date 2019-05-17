(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module System = Nova.System.Make(Nova_cli.System_glfw)

let () =
  System.run "Novapilot" (module Pilot : Nova.Engine.Game)

           
