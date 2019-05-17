(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

(*
% strength, speed
% wisdom, ego
% intellect, size
 *)
type mobType = Mammal | Zombie | Undead | Robot
               | Machine | Reptile

type stat = Strength | Dexterity | Agility
            | Wisdom | Luck

type element =
  Earth (* strength *)
| Water (* Dex *)
| Fire (* Agi *)
| Air (* Int *)
| Spirit (* Luck *)

