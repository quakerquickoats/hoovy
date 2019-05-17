(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

type cell =
  Floor
| Water
| Wall
| UpSlope
| DownSlope
| Warp

type actor =
  Player
| Enemy
| Friend
| Warp

(*
resources(
	% fire! PRINT, activity
	sin,
	sound,
	simulation,
	% AI! EVAL, execution
	air,   
	actors,
	asserts,
	% water! READ, world
	mem,
	malkot,  %<- managers, methods?
	maps).
 *)

(*
% 3x3 aleph,shin,mem
resourceFolders(actors,actions,assets,
				sounds,scripts,sprites,
				messages,maps,methods).
 *)

(*********************************)

type t = {
    seed: int;
    player: Actor.t;
    test: int;
  }

type config = {
    seed: int;
    playerName: string;
  }
let defaultConfig () =
  Random.self_init();
  let seed = Random.bits() in
  Printf.printf "seed: %i\n" seed;
  Random.init(seed);  (* generally 9 digits. *)
  {seed;
   playerName="huma"}

let create () =
  let {seed;playerName} = defaultConfig() in
  {seed;
   player=Actor.createPlayer playerName;
   test=1}

let model _g m =
  m

let step g _t = g

let stop _ = ()

