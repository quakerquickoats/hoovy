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

let create () = {test=1}
       
let start = Nova.Engine.Scene.empty
let step g _t = g
let stop _ = ()
                 
