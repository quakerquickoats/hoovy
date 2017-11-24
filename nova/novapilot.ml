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

module Pilot : Nova.Game = struct
  type t = {
      something: int;
      blah: string;
    }

  let up () = {something = 0; blah = "hello";}
  let step g = g
  let render g = ()
  let down () = ()
end

module Novapilot = Nova.System(Pilot)
                 
let main () =
  let n = Novapilot.init () in
  Novapilot.run n;
  Novapilot.quit n
   
let () = main ()
           
