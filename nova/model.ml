(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module Part = struct
  type t = {
      number: float;
      origin: Geom.v2;
    }
  let create t v = {number=t; origin=v}
  let origin p = p.origin
  let number p = p.number
end

type part = Point of v2
          | Line of Geom.line
          | Circle of Geom.circle
          | Winding of Geom.winding

(*********************************************)

type t = Part.t list

   (* type t = {
    *     parts: Part.t list
    *   }
    * 
    * let empty = {parts=[]} *)

(* let render m = function
 *   | Point ->  *)
