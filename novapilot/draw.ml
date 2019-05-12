(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module Make(C: JsOfOCairo.S) = struct
  let text c s =
    C.set_font_size c 22.;
    C.move_to c 22. 22.;
    (* 
       agh ! monospace is just [][][][] blocks.
       dejavu is completely reversed from RtoL.
       courier is a little few pixels
       clean is completely fixed up for LtoR !

        ... there must be a good one.
        for now, we reverse strings and it works for all.
     *)
    (* C.select_font_face c "dejavu"; *)
    C.show_text c s
  
  let testArc c =
    C.save c;
    C.arc c 50. 50. ~r:40. ~a1:0. ~a2:5.;
    C.stroke c;
    C.set_source_rgb c 1. 1. 1.;
    text c "תיבףלא";
    C.restore c

  let layer c =
    C.save c;
    (* clear the layer *)
    C.set_source_rgba c 0. 0. 0. 0.;
    C.set_operator c C.SOURCE;
    C.paint c;
    C.set_operator c C.OVER;
    C.restore c
end

type layer = {x:int;
  }

(* module Nova = struct *)
  (* include Nova_util
   * include Nova_math
   * include Nova_input *)
(* end *)

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
