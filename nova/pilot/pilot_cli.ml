(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

let () = print_endline "duffhfhfhfhfhfhhfhfhfhfhf"

module System = Nova.System.Make(Nova.System_raylib)

let () =
  print_endline "duifaiudhfasdf";
  System.run "Novapilot" (module Pilot : Nova.Engine.Game)

           
