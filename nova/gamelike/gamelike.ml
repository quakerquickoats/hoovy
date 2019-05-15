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
    test: int;
  }

let initialState =
  {test=1}

let cleanup _ = ()

let step g _t = g
let render _ = ()

