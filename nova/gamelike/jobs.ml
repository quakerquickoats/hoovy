(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

                       
(*
% FIXME: there are two MASONs.
job(atheist, mason, scientist).
job(gnostic, gypsy, summoner).
job(buddhist, zen, monk).
job(muslim, sufi, alchemist).
job(jewish, kabbalist, sage).
job(catholic, mason, sorcerer).
job(taoist, priest, magician).
job(hindu, guru, wizard).

class(scientist).
class(zen).
class(sufi).
class(kabbalist).
class(mason).
 *)


type job =
  Novice | Merchant | Archer | Soldier
  | Thief | Acolyte | Mage

(* hmm only six??  should be six stats then. *)
let jobStats x = match x with
  | Novice -> (0,0,0,0,0)
  | Merchant -> (0,0,0,0,1)
  | Archer -> (0,1,0,0,0)
  | Soldier -> (1,0,0,0,0)
  | Thief -> (0,0,1,0,0)
  | Acolyte -> (0,0,0,1,0)
  | Mage -> (0,0,0,0,0)
end
