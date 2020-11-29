
module Performance = struct
  type mutator =
    Static
  | Many of mutator list | AtCenterDo of mutator
  | AutoCurve of int | AutoIncurve of int

  type 'a perfstep = Trans of mutator
                  | Render of 'a
  type 'a process = 'a perfstep list

  type procedural =
    Default
  | Gradient of Math.compassDirection
  | Textured of string | Model of string | Image of string
  (* editor *)
  | EditNote of string
  | ResPreview of string option
  | ResMaking of string option
  | Wired | WireColored | Bounds
  | TravelKnot | StepVecs of float
                           
  type synthesizer =
    Silent
  | Wavetable of string | Volume of float
  | SineOsc of float

  type t = Visual of procedural process
         | Ethereal of mutator process
         | Aural of synthesizer process
end
                               
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
      travel: Geom.v3;
      winding: Geom.winding;
      trans: Performance.mutator list;
    }

  let create () =
    {layer = 0;
     flags = "";
     perform = None; (* Visual (Default Default); *)
     travel = Geom.zero3;
     winding = [];
     trans = [];
    }
  let step t = t
  let cleanup _ = ()
end
