(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova

let () =
  Nova.init 240 320;
  print_string "Okay.";
  print_newline ();
  while Nova.update () do
    Nova.endFrame ();
  done;
  Nova.shutdown ()
    

