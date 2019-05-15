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


(* rearrange this. *)

type element =
  Earth (* strength *)
| Water (* Dex *)
| Fire (* Agi *)
| Wind (* Int *)
| Spirit (* Luck *)

(*
equipSlots:- [head,body,arms,leftHand,rightHand,
  face,legs,feet,back].
 *)

(*
	FirstNames = [job,david,moshe,abraham,jacob,isaac],
	LastNames = [israel,benjamin,levi,dan,asher],

 *)

type stats = {
    level: int;
    hp: int;
    sp: int;
    xp: int;
    str: int;
    agi: int;
    dex: int;
    wis: int;
    luk: int;
  }

type t = {
    stats: stats;
  }
