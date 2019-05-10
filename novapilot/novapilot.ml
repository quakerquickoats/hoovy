(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova

let () =
  let w = Nova.init 240 320 in
  print_string "Okay.";
  print_newline ();
  while Nova.update w do
    Nova.endFrame w;
  done;
  Nova.shutdown w
    

