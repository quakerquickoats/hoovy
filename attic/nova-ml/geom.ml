(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

type scalar = float
type v2 = scalar*scalar
type v3 = scalar*scalar*scalar
type v4 = scalar*scalar*scalar*scalar

type line = v2
type circle = v3
type rect = v4

let zero2 = (0., 0.)
let zero3 = (0., 0., 0.)
let zero4 = (0., 0., 0., 0.)
        
(*******************************************)

module type Vector = sig
  type t
  val zero: t
end
        
module Vertex(S : Vector) = struct end

(*******************************************)

type step = {
    v:v2;
    p:v2;
    color:v4;
    (* x y u v r g b a *)
  }

let emptyStep = {v=zero2;p=zero2;color=zero4}

type winding = step list
   
