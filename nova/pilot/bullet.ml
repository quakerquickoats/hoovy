(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

type kind = NormalShot

open Nova.Geom
   
type t = {
    kind: kind;
    pos: v2;
    vel: v2;
    mag: v2;
  }

module type Pattern = sig
  type t
end

module Make (P:Pattern) = struct
  let shoot num =
    [{kind=NormalShot;
      pos=(0.,0.);
      vel=(0.,0.);
      mag=(0.,0.)}]
end
