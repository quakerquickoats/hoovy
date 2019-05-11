(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova
open System_glfw
   
let () =
  let w = System.init 240 320 "Novapilot" in
  while System.update w do
    Nova.prepareScene ();
    System.endFrame w;
  done;
  System.shutdown w
    
