open Ctypes
open Foreign
   
module Lisp = struct       
  type cl_object = unit ptr
  let cl_object: cl_object typ = ptr void

(*  type cl_narg = Int64
  let cl_narg: cl_narg typ = Int64.t *)

  let cl_boot = foreign "cl_boot" (int @-> ptr char @-> returning int)
  let cl_shutdown = foreign "cl_shutdown" (void @-> returning void)
      
  let ecl_make_integer = foreign "ecl_make_integer" (int @-> returning cl_object)

                       
  let cl_def_c_function = foreign "ecl_def_c_function"
                            (cl_object @-> cl_object @-> int @-> returning void)
(*  let si_safe_eval = foreign "si_safe_eval"
                       (cl_narg @-> cl_object @-> cl_object @-> returning cl_object)  *)
end
