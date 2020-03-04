open Bigarray

(*
  ooo oXo ooo
  ooo ooo ooo
  Xoo ooo ooX
  Xoo ooo ooX
  Xoo ooo ooX
  Xoo ooo ooX
  XXo ooo ooX
  ooX Xoo ooo
  ooo oXo ooo
 *)

module Cell = struct
  type cell = {contents: int;}
  
  type t = Cell of cell
         | Cells of cell array

  let create () =
    let x = Array.make 9 {contents=0} in
    Cells x
end


       

       
