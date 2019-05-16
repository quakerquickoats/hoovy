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

module Gear = struct
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
            
(**********************************************)

module Scene = struct
  type t = {g: Gear.t list}
end
                 
(**********************************************)

module type Game = sig
  type t
  (* val engine: Engine.t *)
  val initialState: t
  val step: t -> float -> t
  val render: t -> unit
  val cleanup: t -> unit
end

(**********************************************)

module Make(G: Game) = struct
  type t = {
      lastTime: float;
      gears: Gear.t list;
      (* actors: Actor.t list; *)
    }

  let create now =
    (* let e = {lastTime=now;gears=[]} in
     * fun tick -> (G.step e tick) *)
    {lastTime=now;gears=[]}
  
  let step e now =
    let _tick = now -. e.lastTime in
    {lastTime=now;gears=e.gears}
end



                                           

