(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Gg
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
    poop: float;
  }

let create () = {test=1;poop=0.}

let step g _tick = {test=g.test + 1; poop=_tick}
              
let model g _m =
  [Nova.Engine.Part.create g.poop (V2.v 20. 20.);
   Nova.Engine.Part.create (1. /. g.poop) (V2.v 100. 100.);
   Nova.Engine.Part.create (float_of_int g.test)
     (V2.v 100. 200.)]

let stop _ = ()
                 
