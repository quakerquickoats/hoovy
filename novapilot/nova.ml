(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module Make(C: JsOfOCairo.S) = struct
  let draw ctx =
    C.save ctx;
    C.arc ctx 50. 50. ~r:40. ~a1:0. ~a2:5.;
    C.stroke ctx;
    C.restore ctx
end
