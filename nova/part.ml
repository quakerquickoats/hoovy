open Gg

module Huma_math = struct
  type compass_direction =
    North | NorthEast | East | SouthEast | South | SouthWest | West | NorthWest
end                                             

type travel = v3

type 'a maybe = Nothing | Just of 'a
            
type mutator =
  Static
| Many of mutator list | AtCenterDo of mutator
| AutoCurve of int | AutoIncurve of int

type procedural =
  Default
| Gradient of Huma_math.compass_direction
| Textured of string | Model of string | Image of string
(* editor *)
| EditNote of string | ResPreview of string maybe | ResMaking of string maybe
| Wired | WireColored | Bounds | TravelKnot | StepVecs of float

type synthesizer =
  Silent
| Wavetable of string | Volume of float | SineOsc of float

let synthesizer Silent _ = 0.
let synthesizer (SineOsc freq) p = sin freq
(*let synthesizer (SineOsc freq) p = List.map sin (iterate (2*.pi*.freq +.) 0) *)
                                                        
type 'a perfstep = Trans of mutator | Render of 'a
            
type 'a process = 'a perfstep list
            
type performance = Visual | Ethereal of procedural process | Aural of synthesizer process
            
module Part = struct
  type t = {
      layer: int;
      flags: string;
      
      perf: performance;
      travel: travel;
      winding: Winding.winding;
      trans: mutator list;
    }
end
