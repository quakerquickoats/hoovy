open Geom

type model = {
    windings: Geom.Winding.t
  }

module type Scene = sig
  type t
  val start: unit -> t
  val step: t -> t
  val cleanup: t -> unit
end

module Scene = struct
  (* let render s = List.map Part.render s.parts *)
end
               
module type Game = sig
  (* a Play *)
  type t
  val scene: Scene.t
  (*type scenes = Scene list*)
  (* clock, heart, breath, rhythm, beat *)
  val initial_state: unit -> t
  val step: t -> float -> t
  val render: t -> unit
  val cleanup: t -> unit
end

module Game = struct
  type x = {bummer: int;}
  let make_happen p = Printf.printf "POoppppyy: %d\n" (p.bummer)
end
