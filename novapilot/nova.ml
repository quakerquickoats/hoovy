(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* open Tgl3 *)

module Nova = struct
  (* include Nova_util
   * include Nova_math
   * include Nova_input *)
end

(*
  (*
  let init = foreign "NV_Init" (int @-> int @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
  let update = foreign "NV_Update" (int @-> returning int)
   *)

  external init : int -> int -> unit = "NV_Init" [@@noalloc]
  external update : unit -> bool = "NV_Update" [@@noalloc]
  external endFrame : unit -> unit = "NV_EndFrame" [@@noalloc]
  external getTime : unit -> float = "NV_GetTime" [@@noalloc]
  external shutdown : unit -> unit = "NV_Shutdown" [@@noalloc]
 *)
