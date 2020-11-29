open Gg

module type Step = sig
  type t
  val vertex: t -> v2
end

module Step = struct
  type t = {v: v2; t: v2; c: v4}
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

  let of_spherical _sv = ignore
  let to_spherical _a = ignore

  let of_v2 _a ~_z = ignore
  let of_v4 _a = ignore

  let neg a = v (V2.neg a.v) (V2.neg a.t) (V4.neg a.c)
  let add a b = v (V2.add a.v b.v) (V2.add a.t b.t) (V4.add a.c b.c)
  let sub a b = v (V2.sub a.v b.v) (V2.sub a.t b.t) (V4.sub a.c b.c)
end

module Winding = struct
  type t = Step.t list
  let spiral2 a = Util.zip (Util.rotatel a)
  let as_edges = spiral2
  let as_vertices a = List.map Step.vertex a
  let as_lines a =
    let vs = as_vertices a in Util.zip vs (Util.rotatel vs)

  let empty = []
end

(* let test_w = [Step.v (V2.v 1. 1.) (V2.v 0. 0.) (V4.zero);
 *               Step.v (V2.v 2. 3.) (V2.v 0. 0.) (V4.zero);
 *               Step.v (V2.v 4. 5.) (V2.v 0. 0.) (V4.zero)] *)

