let pl_engine = ref (Nova.new_engine ())

let next () = pl_engine := Nova.step !pl_engine
         
let run () = ()
let pause () = ()

let runUntil time = ()
let runFor seconds = ()

let speed s = () (* set engine tick_mul *)

(**************)

let main () =
  let st = Nova.init () in
  Nova.quit st
   
let () = main ()
           
