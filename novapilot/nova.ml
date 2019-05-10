(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

  (*
  let init = foreign "NV_Init" (int @-> int @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
  let update = foreign "NV_Update" (int @-> returning int)
   *)

open System_glfw;;

module Nova = struct
  type t = {
      window: GLFW.window
    }

  let init = System.init
  let update = System.update
  let endFrame = System.endFrame
  let shutdown = System.shutdown
              
(*
  external init : int -> int -> unit = "NV_Init" [@@noalloc]
  external update : unit -> bool = "NV_Update" [@@noalloc]
  external endFrame : unit -> unit = "NV_EndFrame" [@@noalloc]
  external getTime : unit -> float = "NV_GetTime" [@@noalloc]
  external shutdown : unit -> unit = "NV_Shutdown" [@@noalloc]
 *)
end
