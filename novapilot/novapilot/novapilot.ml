(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Gg

type map = {
    width: int;
    height: int;
    cells: int * int;
  }

type actor = {
    pos: v2;
    vel: v2;
    hp: int;
  }

type player = actor
type bullet = actor
            
let () = ()
