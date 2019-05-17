(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)


(*
	FirstNames = [job,david,moshe,abraham,jacob,isaac],
	LastNames = [israel,benjamin,levi,dan,asher],

 *)

type stats = {
    level: int;
    element: Mob.element option;
    hp: int;
    sp: int;
    xp: int;
    str: int;
    dex: int;
    agi: int;
    wis: int;
    luk: int;
  } [@@deriving sexp]

(* rearrange this. *)
(* let statForElement e s = match e with
 *   | Earth -> s.str
 *   | Water -> s.dex
 *   | Fire -> s.agi
 *   | Air -> s.wis
 *   | Spirit -> s.luk *)

let defaultStats = {level=1;
                    element=None;
                    hp=10;
                    sp=1;
                    xp=0;
                    str=1;
                    agi=1;
                    dex=1;
                    wis=1;
                    luk=1}

type equip = Item.t option
type t = {
    name: string option;
    stats: stats;

    inventory: Item.t list;
    
    (* equipment *)
    head: equip;
    body: equip;
    leftHand: equip; rightHand: equip;
    legs: equip; feet: equip;
  } [@@deriving sexp]

let create () =
  {name=None;
   stats=defaultStats;
   inventory=[];
   head=None; body=None;
   leftHand=None; rightHand=None;
   legs=None; feet=None}

(*****************************************)

let randomInventory p =
  p.inventory
let equipRandomly p =
  p
let randomStats p =
  p.stats
  
let createPlayer name =
  let c = create() in
  let p = {c with
            name=Some name;
            stats=randomStats c;
            inventory=randomInventory c} in
  equipRandomly(p)
