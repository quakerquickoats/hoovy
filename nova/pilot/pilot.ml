(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(* open Nova *)

(* module Level : Nova.Gearbox = struct
 *   type t = {hi:int}
 *   let start = {hi=0}
 *   let step l = l
 *   let cleanup _ = ()
 * end *)

(* type map = {
   *     width: int;
   *     height: int;
   *     cells: int * int;
   *   }
   * 
   * type actor = {
   *     pos: v2;
   *     vel: v2;
   *     hp: int;
   *   }
   * 
   * type player = actor
   * type bullet = actor *)

type player = {
    score: int;
    lives: int;
    bombs: int;
  }

let defaultPlayer = {score=0;
                     lives=3;
                     bombs=3}
   
(**********************************************)
   
type t = {
    frames: int;
    tick: float;
    player: player;
    enemies: Enemy.t list;
    bullets: Bullet.t list;
    (* paths: Nova.Geom.winding list; *)
  }

type config = {name: string}
let defaultConfig () = {name="Player"}
       
let create () = {frames=0;
                 tick=0.;
                 player=defaultPlayer;
                 enemies=[];
                 bullets=[]}

let step g tick =
  let enemies = List.map (Enemy.move tick) g.enemies in
  {g with frames=g.frames + 1;
          tick;
          enemies}
              
let model g _m =
  List.map Enemy.model g.enemies
  @
    [Nova.Model.Part.create g.tick (20., 20.);
      Nova.Model.Part.create (1. /. g.tick) (100., 100.);
      Nova.Model.Part.create (float_of_int g.frames)
        (100., 200.)]

let stop _ = ()
                 
