(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

(* module type Item = sig
 *   type t
 *   val canEquip: t -> bool
 *   val canConsume: t -> bool
 *   val canUse: t -> bool
 *   val canSell: t -> bool
 * end *)
                 
type kind = Material | Equip | Food
type t = {
    kind: kind;
    element: Mob.element;
    name: string option;
    weight: int;
    cost: int;
  }

let empty = {kind= Material;
             element= Mob.Earth;
             name= None;
             weight= 1;
             cost= 1}
           
(* let randomOfKind k = function
 *   | Equip ->  *)
