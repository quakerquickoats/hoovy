(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova.Geom
   
type size = Small | Medium | Large
  
type t = {
    lifeTime: float;
    pos: v2;
    (* this could just be a circle. *)
    size: size;
    angle: float;
    path: Winding.t;
  }

let move t e =
  {e with lifeTime=(e.lifeTime +. t)}
       
module type Conductor = sig
  type t
end

module Make (C:Conductor) = struct
  let step e _t = e
end
