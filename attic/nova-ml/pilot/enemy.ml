(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova.Geom
open Nova.Model
   
type size = Small | Medium | Large
  
type t = {
    lifeTime: float;
    pos: v2;
    (* this could just be a circle. *)
    size: size;
    angle: float;
    path: winding;
  }

let move t e =
  {e with lifeTime=(e.lifeTime +. t)}

let model e =
  {Part.number=22.; origin=e.pos}
       
module type Conductor = sig
  type t
end

module Make (C:Conductor) = struct
  let step e _t = e
end
