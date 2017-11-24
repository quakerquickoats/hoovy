module type Huma_util = sig
  val zip: 'a list -> 'b list -> ('a * 'b) list
  val rev_list: 'a list -> 'a list

  val rotatel: 'a list -> 'a list
  val rotater: 'a list -> 'a list
  
  val dbl: 'a -> 'a * 'a
  val trp: 'a -> 'a * 'a * 'a
end
