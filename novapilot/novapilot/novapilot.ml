(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* open Gg *)
(* open Nova *)

(* module Level : Nova.Gearbox = struct
 *   type t = {hi:int}
 *   let start = {hi=0}
 *   let step l = l
 *   let cleanup _ = ()
 * end *)

(* type map = {
   *     width: int;
   *     height: int;
   *     cells: int * int;
   *   }
   * 
   * type actor = {
   *     pos: v2;
   *     vel: v2;
   *     hp: int;
   *   }
   * 
   * type player = actor
   * type bullet = actor *)

type t = {
    test: int;
  }

       (* let () =
 *   System.run "Novapilot" (fun c t ->
 *       Draw.withState c (fun () ->
 *           Draw.clear c;
 *           Cairo.set_source_rgb c 0. 1. 1.;
 *           Cairo.set_font_size c 22.;
 *           Cairo.move_to c 144. 144.;
 *           Draw.text c (string_of_float (1. /. t));
 *         );
 *       Draw.testArc c
 *     ) *)

let initialState () =
  {test=1}

let cleanup _ = ()

let step g _t = g
let render _ = ()

                 
