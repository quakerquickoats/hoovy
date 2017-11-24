open Gg

open Nova
open System
   
(*
let pl_engine = ref (Nova.Engine.create ())

let next () = pl_engine := Nova.Engine.step !pl_engine
 *)

let pause () = ()
let run () = ()
let runUntil time = ()
let runFor seconds = ()

let speed s = () (* set engine tick_mul *)

(**************)

module MainMenu : Nova.Scene = struct
  type t = {
    selected: int;}

  let start () = {selected = 0;}
  let step g = g
  let cleanup g = ()
end

module Level : Nova.Scene = struct
  type t = {
      number: int;
      size: v2;
      reactor: v2;
      map: unit;
      model: unit;
    }

  let start () = {number = 0;
                  size = V2.v 64. 64.;
                  reactor = V2.zero;
                  map = ();
                  model = ();
                 }
  let step g = g
  let cleanup g = ()
end
            
module Pilot : Nova.Game = struct
  type t = {
      something: int;
      blah: string;
      score: int;
    }

  let initial_state () = {
      something = 0;
      blah = "hello";
      score = 0;
    }
  let step g = g
  let render g = ()
  let cleanup g = ()
end

module Novapilot = System(Pilot)                 
let main () = Novapilot.play ()
let () = main ()
           
