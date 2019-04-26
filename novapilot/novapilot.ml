(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova

let () =
  let w = Nova.init 100 100 in
  while Nova.update w do
    Nova.endFrame w;
  done;
  Nova.shutdown w

