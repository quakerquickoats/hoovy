let pl_engine = ref (Nova.Engine.create ())

let next () = pl_engine := Nova.Engine.step !pl_engine

let pause () = ()
let run () = ()
let runUntil time = ()
let runFor seconds = ()

let speed s = () (* set engine tick_mul *)

(**************)
            
let main () =
  let sys = Nova.System.init () in
  Nova.System.loop sys
  Nova.System.quit sys
   
let () = main ()
           
