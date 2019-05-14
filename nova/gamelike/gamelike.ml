(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

type t = {
    test: int;
  }

let initialState =
  {test=1}

let cleanup _ = ()

let step g _t = g
let render _ = ()

