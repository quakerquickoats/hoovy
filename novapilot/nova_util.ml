(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module Nova_util = struct
  let rec zip a b = match a,b with
    | [], _ -> []
    | _, [] -> []
    | (x::xs),(y::ys) -> (x,y) :: (zip xs ys)

  let rev_lst l =
    let rec rev_acc acc = function
      | [] -> acc
      | hd::tl -> rev_acc (hd::acc) tl
    in 
    rev_acc [] l

  let rotatel n = match n with
    | [] -> []
    | (n::ns) -> ns @ [n]

  let rotater a = rev_lst (rotatel a)

  let dbl a = (a,a)
  let trp a = (a,a,a)
end
