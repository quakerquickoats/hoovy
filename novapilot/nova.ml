(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Ctypes
open Foreign
   
module Nova = struct
  (* let _lib = Dl.open ?filename:"nova/nova.so" [Dl.RTLD_LAZY] *)
  let init = foreign "NV_Init" (int @-> int @-> returning void)
end


