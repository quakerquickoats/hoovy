//
// Nova
//
// (c) 2017 Lyndon Tremblay
//

#include <stdio.h>
#include <stdlib.h>
#include <ecl/ecl.h>

#define DEFUN(name,fun,args) \
  cl_def_c_function(c_string_to_object(name), \
    (cl_objectfn_fixed)fun, \
		    args)

cl_object lisp_safe (const char* str)
{
  return cl_safe_eval(c_string_to_object(str), Cnil, Cnil);
}

cl_object lisp (const char* str)
{
  cl_object result = cl_eval(c_string_to_object(str));
  ecl_print(result, ECL_T);
  return result;
}

int main (int argc, char** argv)
{
  cl_boot(argc, argv);
  atexit(cl_shutdown);

  printf("loading...\n");
  lisp("(load \"game.lisp\")");

  return EXIT_SUCCESS;
}
