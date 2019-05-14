(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)


module System = Nova_cli.System_glfw.Conductor(Gamelike)

let () =
  let _ = Nova.Math.East in
  Nova.Testballs.fart ();
  print_string "Gamelike";
  print_newline ()
    
