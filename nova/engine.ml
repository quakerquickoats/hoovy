(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)


module Scene = struct
  type t
end
             
module type Game = sig
  type t
  type config
  val defaultConfig: unit -> config
  val create: unit -> t
  val model: t -> Model.t -> Model.t
  val step: t -> float -> t
  val stop: t -> unit
end

(**********************************************)

module Make(G: Game) = struct
  type t = {
      game: G.t;
      lastTime: float;
      model: Model.t;
      (* models: Model.t list; *)
    }

  let create now =
    {game=G.create ();
     lastTime=now;
     model=[]}
    
  let step e now =
    let tick = now -. e.lastTime in
    let g = G.step e.game tick in
    {game=g;
     lastTime=now;
     model=G.model g e.model}

  let getModel e = e.model
end

(* type t = {
 *     game: Game.t;
 *     lastTime: float;
 *     scene: Scene.t;
 *     gears: Gear.t list;
 *     (\* models: Model.t list; *\)
 *   } *)

           
