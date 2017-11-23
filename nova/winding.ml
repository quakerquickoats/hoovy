open Gg

module Step = struct
  (* type t = v3 *)
  let dim = 3
  type t = { v: v2; t: v2; c: v4; }
  let vertex a = a.v
  let param a = a.t
  let color a = a.c
  let mod_vertex f a = { a with v = (f a.v) }
  let mod_param f a = { a with t = (f a.t) }
  let mod_color f a = { a with c = (f a.c) }
         
  let v v t c = { v = v; t = t; c = c; }
  (* let comp i = V3t.i.(i) *)
  let x a = a.v
  let y a = a.t
  let z a = a.c
  (* ox, oy, oz *)
  let ox = v (V2.v 1. 1.) V2.zero V4.zero
  let oy = v V2.zero (V2.v 1. 1.) V4.zero
  let oz = v V2.zero V2.zero (V4.v 1. 1. 1. 1.)
  let zero = v V2.zero V2.zero V4.zero
  let infinity v = v V2.infinity V2.infinity V4.infinity
  let neg_infinity v = v V2.neg_infinity V2.neg_infinity V4.neg_infinity
  let _basis = [| ox; oy; oz |]
  let basis i = _basis.(i)
  let of_tuple (v', t, c) = v v' t c
  let to_tuple a = (a.v, a.t, a.c)

  let of_spherical sv = ignore
  let to_spherical a = ignore

  let of_v2 a ~z = ignore
  let of_v4 a = ignore

  let neg a = v (V2.neg a.v) (V2.neg a.t) (V4.neg a.c)
  let add a b = v (V2.add a.v b.v) (V2.add a.t b.t) (V4.add a.c b.c)
  let sub a b = v (V2.sub a.v b.v) (V2.sub a.t b.t) (V4.sub a.c b.c)
end

type step = Step.t
module type Step = sig
end

(* type step = v2 * v2 * v4 [@@deriving sexp] *)

                         
                         (* val add : step -> step -> step              *)

(* let add (t,v,c) (t',v',c') =
 *   (add t t', add v v', add c c') *)

let rec zip a b = match a,b with
  | [], _ -> []
  | _, [] -> []
  | (x::xs),(y::ys) -> (x,y) :: (zip xs ys)

let rev_list l =
  let rec rev_acc acc = function
    | [] -> acc
    | hd::tl -> rev_acc (hd::acc) tl
  in 
  rev_acc [] l

let rotatel (n::ns) = ns @ [n]
let rotater a = rev_list (rotatel a)

let dbl a = (a,a)
let trp a = (a,a,a)
                 
module Winding = struct
  type t = step list

  let spiral2 a = zip (rotatel a)
                (* let spiral3 a = let ts = rotatel a in zip3... *)
  let as_edges = spiral2
  let as_vertices a = List.map (fun s -> Step.vertex s) a
  let as_lines a = let vs = as_vertices a in zip vs (rotatel vs)

                                                 (* let map_edges f a = f `zipWith` w $ rotatel w... *)

  (* let is_convex a = is_circle_inside (center_of a, 0) a *)
                  
end

type winding = Winding.t

let test_w = [Step.v (V2.v 1. 1.) (V2.v 0. 0.) (V4.zero);
              Step.v (V2.v 2. 3.) (V2.v 0. 0.) (V4.zero);
              Step.v (V2.v 4. 5.) (V2.v 0. 0.) (V4.zero)]
