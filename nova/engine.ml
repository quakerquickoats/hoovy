(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

open Gg
   
module Performance = struct
  type mutator = Static
               | Many of mutator list | AtCenterDo of mutator
               | AutoCurve of int | AutoIncurve of int

  type 'a perfstep = Trans of mutator
                   | Render of 'a
  type 'a process = 'a perfstep list

  type procedural = Default
                  | Gradient of Math.compassDirection
                  | Textured of string | Model of string | Image of string
                  (* editor *)
                  | EditNote of string
                  | ResPreview of string option
                  | ResMaking of string option
                  | Wired | WireColored | Bounds
                  | TravelKnot | StepVecs of float

  type synthesizer = Silent
                   | Wavetable of string | Volume of float
                   | SineOsc of float

  type t = Visual of procedural process
         | Ethereal of mutator process
         | Aural of synthesizer process
end

(*********************************************)
                   
module type Gear = sig
  type t
  val create: unit -> t
  val step: t -> t
  val cleanup: t -> unit
end

module Part2 : Gear = struct
  type t = {
      layer: int;
      flags: string;

      perform: Performance.t option;
      travel: v3;
      winding: Geom.Winding.t;
      trans: Performance.mutator list;
    }

  let create () =
    {layer = 0;
     flags = "";
     perform = None; (* Visual (Default Default); *)
     travel = V3.zero;
     winding = Geom.Winding.empty;
     trans = [];
    }
  let step t = t
  let cleanup _ = ()
end

module Part = struct
  type t = {
      number: float;
      origin: v2;
    }
  let create t v = {number=t; origin=v}
  let origin p = p.origin
  let number p = p.number
end
            
(**********************************************)

type model = Part.t list
                   
(* module Model = struct
 *   type t = {
 *       parts: Part.t list
 *     }
 * 
 *   let empty = {parts=[]}
 * end *)
                 
(**********************************************)

module Scene = struct
  type t
end
             
module type Game = sig
  type t
  type config
  val defaultConfig: unit -> config
  val create: unit -> t
  val model: t -> model -> model
  val step: t -> float -> t
  val stop: t -> unit
end

(**********************************************)

module Make(G: Game) = struct
  type t = {
      game: G.t;
      lastTime: float;
      model: model;
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

           
