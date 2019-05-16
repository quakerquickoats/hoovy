(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module type System_S = sig
  type t
  val init: int -> int -> string -> t
end
