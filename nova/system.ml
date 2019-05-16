(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module type S = sig
  type t
  val init: Nova.Engine.t -> int -> int -> string -> t
  val update: t -> bool
  val endFrame: t -> unit
  val getTime: unit -> float
end

module S = struct
  (* let run title engine =
 *   let sys = init 320 240 title engine in
 *   
 *   shutdown sys *)

end
