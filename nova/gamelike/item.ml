(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

module type Item = sig
  type t
  val canEquip: t -> bool
  val canConsume: t -> bool
  val canUse: t -> bool
  val canSell: t -> bool
end
                 
type kind = Equip | Food
type t = {
    kind: kind;
    weight: int;
    cost: int;
  }

(* let randomOfKind k = function
 *   | Equip ->  *)
