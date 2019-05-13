(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module type Game = sig
  type t
  val start: unit -> t
  val step: t -> float -> t
  val render: t -> unit
  val cleanup: t -> unit
end

module W =   Geom.Winding.Make(Geom.Step)
