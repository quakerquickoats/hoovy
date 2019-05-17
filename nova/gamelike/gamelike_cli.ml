(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)


module System = Nova.System.Make(Nova_cli.System_glfw)

let () =
  (module Gamelike:Nova.Engine.Game) |>
    System.runHeadless "Gamelike"
