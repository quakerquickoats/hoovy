open Gg
open Huma
open Geom
   
type travel = v3

type mutator =
  Static
| Many of mutator list | AtCenterDo of mutator
| AutoCurve of int | AutoIncurve of int

type procedural =
  Default
| Gradient of Huma.compass_direction
| Textured of string | Model of string | Image of string
(* editor *)
| EditNote of string | ResPreview of string option | ResMaking of string option
| Wired | WireColored | Bounds | TravelKnot | StepVecs of float

type synthesizer =
  Silent
| Wavetable of string | Volume of float | SineOsc of float

let synthesizer s p = match s with
  | Silent -> 0.
  | (SineOsc freq) -> sin freq
  | _ -> 0.
       
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
      winding: Winding.t;
      trans: mutator list;
    }
end
